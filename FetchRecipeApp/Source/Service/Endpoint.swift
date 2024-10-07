//
//  Endpoint.swift
//  FetchRecipeApp
//
//  Created by Luis Arias on 07/10/24.
//

import Foundation

enum Endpoint: String, CaseIterable, Identifiable {
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

  static var currentEndpoint: Endpoint = .valid
}
