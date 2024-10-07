//
//  Sentiment.swift
//  FetchRecipeApp
//
//  Created by Luis Arias on 06/10/24.
//

import SwiftUI

enum Sentiment {
  /// Represents a negative sentiment, typically used when an error has occurred.
  case negative
  /// Represents a neutral sentiment.
  case neutral

  var color: Color {
    switch self {
    case .negative: .red
    case .neutral: Color(uiColor: UIColor.systemGray4)
    }
  }
}
