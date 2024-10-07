//
//  Networking.swift
//  FetchRecipeApp
//
//  Created by Luis Arias on 04/10/24.
//

import Foundation

enum TestURL: String, CaseIterable, Identifiable {
  case valid
  case malformed
  case empty

  var id: String { self.rawValue }

  var url: URL {
    switch self {
    case .valid: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!
    case .malformed: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json")!
    case .empty: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json")!
    }
  }

  static var currentTestURL: TestURL = .valid
}

struct Networking {
  static func loadRecipes() async throws -> [Recipe] {
    let url = TestURL.currentTestURL.url
    let response = try await URLSession.shared.data(from: url)
    let recipesResponse = try JSONDecoder().decode(RecipesResponse.self, from: response.0)
    return recipesResponse.recipes
  }

  static func loadImage(url: URL) async throws -> Data {
    let response = try await URLSession.shared.data(from: url)
    return response.0
  }
}
