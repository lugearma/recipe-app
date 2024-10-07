//
//  RecipesListViewModel.swift
//  FetchRecipeApp
//
//  Created by Luis Arias on 05/10/24.
//

import Combine

@MainActor
class RecipeListViewModel: ObservableObject {
  private let service: RecipesServiceProtocol
  @Published var loadingState: LoadingState<ListState<[RecipeRowViewModel]>> = .idle
  @Published var isEndpointDialogPresented = false

  private var recipesViewModel: [RecipeRowViewModel] {
    guard case .loaded(let listState) = self.loadingState,
          case .filled(let viewModels) = listState else {
      return []
    }

    return viewModels
  }

  init(service: RecipesServiceProtocol) {
    self.service = service
  }

  func loadRecipes() async {
    if case .idle = self.loadingState {
      self.loadingState = .loading
    }

    do {
      let recipes = try await self.service.loadRecipes()
      if recipes.isEmpty {
        self.loadingState = .loaded(.empty)
      } else {
        self.loadingState = .loaded(.filled(recipes.map {
          RecipeRowViewModel(recipe: $0, service: self.service)
        }))
      }
    } catch {
      self.loadingState = .failed
    }
  }

  func onTapChangeEndpoint() {
    self.isEndpointDialogPresented = true
  }

  func onRefresh() async {
    await self.loadRecipes()
  }
}
