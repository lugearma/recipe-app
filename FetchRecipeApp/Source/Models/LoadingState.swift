//
//  LoadingState.swift
//  FetchRecipeApp
//
//  Created by Luis Arias on 04/10/24.
//

import Foundation

enum LoadingState<Value> {
  /// Default state. Nothing has been loaded yet.
  case idle
  /// State to indicate that loading operation has started.
  case loading
  /// State to indicate that loading operation has been completed successfully containing
  /// the result of the operation.
  case loaded(Value)
  /// Indicates that operation failed.
  case failed
}

