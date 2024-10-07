//
//  Recipe.swift
//  FetchRecipeApp
//
//  Created by Luis Arias on 04/10/24.
//

import Foundation

struct Recipe: Identifiable, Decodable, Equatable {
  let uuid: String
  let name: String
  let cuisine: Cuisine
  private let photoURLString: String

  var photoURL: URL? {
    URL(string: self.photoURLString)
  }

  var id: String {
    self.uuid
  }

  enum CodingKeys: String, CodingKey {
    case uuid
    case name
    case cuisine
    case photoURLString = "photo_url_small"
  }
}
