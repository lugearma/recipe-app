//
//  RecipesList.swift
//  FetchRecipeApp
//
//  Created by Luis Arias on 04/10/24.
//

import SwiftUI

struct RecipesList: View {
  @ObservedObject var model: RecipeListViewModel

  var body: some View {
    Group {
      LoadableContentView(
        loadingState: self.model.loadingState,
        content: { listState in
          self.displayContent(for: listState)
        },
        failedContent: {
          FeedbackView(configuration: .error, retryAction: {
            Task {
              await self.model.loadRecipes()
            }
          })
        }
      )
    }
    .navigationTitle("Recipes")
    .toolbar(content: {
      Button(action: {
        self.model.onTapChangeEndpoint()
      }, label: {
        Image(systemName: "gear")
      })

      Button(action: {
        Task {
          await self.model.onRefresh()
        }
      }, label: {
        Image(systemName: "arrow.clockwise")
      })
    })
    .confirmationDialog(
      "Select endpoint",
      isPresented: self.$model.isEndpointDialogPresented,
      actions: {
        ForEach(Endpoint.allCases) { testURL in
          Button(
            testURL.rawValue.capitalized,
            action: {
              Endpoint.currentEndpoint = testURL
            }
          )
        }
      },
      message: {
        Text("Select endpoint")
      }
    )
    .task {
      await self.model.loadRecipes()
    }
  }

  @ViewBuilder
  private func displayContent(for listState: ListState<[RecipeRowViewModel]>) -> some View {
    switch listState {
    case .empty:
      FeedbackView(
        configuration: .empty,
        retryAction: {
          Task {
            await self.model.loadRecipes()
          }
        }
      )
    case .filled(let recipes):
      self.makeList(recipes)
    }
  }

  private func makeList(_ recipes: [RecipeRowViewModel]) -> some View {
    List(recipes) { rowViewModel in
      RecipeRow(viewModel: rowViewModel)
        .onAppear {
          Task {
            await rowViewModel.loadImageData()
          }
        }
    }
    .refreshable {
      await self.model.onRefresh()
    }
  }
}

#Preview {
  RecipesList(model: .init(service: RemoteService()))
}
