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
  @Published var loadingImageDataState: LoadingState<Data> = .idle

  init(recipe: Recipe) {
    self.recipe = recipe
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
      let data = try await Networking.loadImage(url: url)
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
