//
//  ListState.swift
//  FetchRecipeApp
//
//  Created by Luis Arias on 06/10/24.
//

enum ListState<Item> where Item: Collection {
  /// Indicates that the list contains one or more items.
  case filled(Item)
  /// Indicates that the list is empty and has no items.
  case empty
}
