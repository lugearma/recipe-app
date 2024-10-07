//
//  FetchRecipeAppApp.swift
//  FetchRecipeApp
//
//  Created by Luis Arias on 04/10/24.
//

import SwiftUI

@main
struct FetchRecipeAppApp: App {
  private let recipeListViewModel = RecipeListViewModel(service: RemoteService())

  var body: some Scene {
    WindowGroup {
      NavigationStack {
        RecipesList(model: self.recipeListViewModel)
      }
    }
  }
}
