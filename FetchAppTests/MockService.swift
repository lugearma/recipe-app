//
//  MockService.swift
//  FetchRecipeApp
//
//  Created by Luis Arias on 07/10/24.
//

import Foundation

struct MockService: RecipesServiceProtocol {
  let fileLoader: FileContentLoader

  func loadRecipes() async throws -> [Recipe] {
    let content = self.fileLoader.loadContent()
    let response = try JSONDecoder().decode(RecipesResponse.self, from: content.data(using: .utf8)!)
    return response.recipes
  }

  func loadImage(url: URL) async throws -> Data {
    Data()
  }
}
