//
//  RecipesListViewModel.swift
//  FetchRecipeApp
//
//  Created by Luis Arias on 05/10/24.
//

import Combine

@MainActor
class RecipeListViewModel: ObservableObject {
  @Published var loadingState: LoadingState<ListState<[RecipeRowViewModel]>> = .idle
  @Published var isEndpointDialogPresented = false

  private var recipesViewModel: [RecipeRowViewModel] {
    guard case .loaded(let listState) = self.loadingState,
          case .filled(let viewModels) = listState else {
      return []
    }

    return viewModels
  }

  func loadRecipes() async {
    if case .idle = self.loadingState {
      self.loadingState = .loading
    }

    do {
      let recipes = try await Networking.loadRecipes()
      if recipes.isEmpty {
        self.loadingState = .loaded(.empty)
      } else {
        self.loadingState = .loaded(.filled(recipes.map(RecipeRowViewModel.init)))
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
