//
//  RecipesServiceProtocol.swift
//  FetchRecipeApp
//
//  Created by Luis Arias on 07/10/24.
//

import Foundation

protocol RecipesServiceProtocol {
  func loadRecipes() async throws -> [Recipe]
  func loadImage(url: URL) async throws -> Data
}
