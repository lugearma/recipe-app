//
//  RecipeRowViewModel.swift
//  FetchRecipeApp
//
//  Created by Luis Arias on 05/10/24.
//

import Combine
import Foundation

@MainActor
class RecipeRowViewModel: ObservableObject, Identifiable {
  let id = UUID()
  let recipe: Recipe
  let service: RecipesServiceProtocol
  @Published var loadingImageDataState: LoadingState<Data> = .idle

  init(recipe: Recipe, service: RecipesServiceProtocol) {
    self.recipe = recipe
    self.service = service
  }

  func loadImageData() async {
    if case .loaded = self.loadingImageDataState {
      return
    }

    if case .idle = loadingImageDataState {
      self.loadingImageDataState = .loading
    }

    guard let url = recipe.photoURL else {
      self.loadingImageDataState = .failed
      return
    }

    do {
      let data = try await self.service.loadImage(url: url)
      self.loadingImageDataState = .loaded(data)
    } catch {
      self.loadingImageDataState = .failed
    }
  }
}

extension RecipeRowViewModel: Hashable, Equatable {
  nonisolated static func == (lhs: RecipeRowViewModel, rhs: RecipeRowViewModel) -> Bool {
    lhs === rhs
  }

  nonisolated func hash(into hasher: inout Hasher) {
    hasher.combine(self.recipe.id)
  }
}
