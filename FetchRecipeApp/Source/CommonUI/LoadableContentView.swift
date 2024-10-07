//
//  LoadableList.swift
//  FetchRecipeApp
//
//  Created by Luis Arias on 06/10/24.
//

import SwiftUI

struct LoadableContentView<Value, Content: View, FailedView: View>: View {
  private let loadingState: LoadingState<Value>
  private let content: (Value) -> Content
  private let failedContent: () -> FailedView

  /// Initializes a view that displays different content based on the loading state.
  ///
  /// - parameter loadingState:  Represents the current state of the loading process, which could be idle, loading, loaded, or failed.
  /// - parameter content:       A closure that takes the loaded value and returns the content to be displayed
  ///                            when the loading is completed successfully.
  /// - parameter failedContent: A closure that returns the view to be displayed when the loading process fails.
  init(loadingState: LoadingState<Value>,
       @ViewBuilder content: @escaping (Value) -> Content,
       @ViewBuilder failedContent: @escaping () -> FailedView) {
    self.loadingState = loadingState
    self.content = content
    self.failedContent = failedContent
  }

  var body: some View {
    switch self.loadingState {
    case .idle:
      Color.clear
    case .loading:
      ProgressView()
    case .loaded(let listState):
      self.content(listState)
    case .failed:
      self.failedContent()
    }
  }
}
