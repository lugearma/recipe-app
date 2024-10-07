//
//  FeedbackView.swift
//  FetchRecipeApp
//
//  Created by Luis Arias on 05/10/24.
//

import SwiftUI

private let kImageWidth: CGFloat = 80
private let kImageHeight: CGFloat = 80
private let kContentOffsetYAxis: CGFloat = 100

struct FeedbackView: View {
  struct Configuration {
    let sentiment: Sentiment
    let image: Image
    let message: String
  }

  let configuration: Configuration
  let retryAction: () -> Void

  /// Initializes a `FeedbackView` instance, commonly used to inform the user about a specific situation, such as an error etc...
  ///
  /// - parameter configuration: A configuration object to be displayed in the view.
  /// - parameter retryAction:   A closure that is executed when the user presses the retry button.
  init(configuration: Configuration, retryAction: @escaping () -> Void) {
    self.configuration = configuration
    self.retryAction = retryAction
  }

  var body: some View {
    ScrollView {
      VStack(spacing: Spacing.six) {
        self.configuration.image
          .resizable()
          .frame(width: kImageWidth, height: kImageHeight)
          .foregroundStyle(self.configuration.sentiment.color)

        Text(self.configuration.message)
          .multilineTextAlignment(.center)

        Button(action: {
          self.retryAction()
        }, label: {
          Text("Retry")
        })
        .bold()
        .buttonStyle(.borderedProminent)
      }
      .offset(y: kContentOffsetYAxis)
      .padding(.horizontal)
    }
  }
}

extension FeedbackView.Configuration {
  static let error = FeedbackView.Configuration(sentiment: .negative,
                                                image: Image(systemName: "exclamationmark.circle.fill"),
                                                message: "An error has occurred while processing your request. Please try again.")
  static let empty = FeedbackView.Configuration(sentiment: .neutral,
                                                image: Image(systemName: "magnifyingglass.circle.fill"),
                                                message: "Looks like there's nothing here.")
}


#Preview {
  FeedbackView(configuration: .error, retryAction: {})
}

#Preview {
  FeedbackView(configuration: .empty, retryAction: {})
}
