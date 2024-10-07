//
//  Networking.swift
//  FetchRecipeApp
//
//  Created by Luis Arias on 04/10/24.
//

import Foundation

struct RemoteService: RecipesServiceProtocol {
  func loadRecipes() async throws -> [Recipe] {
    let url = Endpoint.currentEndpoint.url
    let response = try await URLSession.shared.data(from: url)
    let recipesResponse = try JSONDecoder().decode(RecipesResponse.self, from: response.0)
    return recipesResponse.recipes
  }

  func loadImage(url: URL) async throws -> Data {
    let response = try await URLSession.shared.data(from: url)
    return response.0
  }
}
