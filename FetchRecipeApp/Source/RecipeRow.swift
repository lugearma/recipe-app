//
//  RecipeRow.swift
//  FetchRecipeApp
//
//  Created by Luis Arias on 04/10/24.
//

import SwiftUI

private let kRecipeImageWidth: CGFloat = 100
private let kRecipeImageHeight: CGFloat = 100

struct RecipeRow: View {
  @ObservedObject var viewModel: RecipeRowViewModel

  var body: some View {
    HStack {
      self.recipeImage
        .clipShape(RoundedRectangle(cornerRadius: Spacing.two))
        .frame(width: kRecipeImageWidth, height: kRecipeImageHeight)

      VStack(alignment: .leading) {
        Text(self.viewModel.recipe.name)
          .font(.body2)

        Text(self.viewModel.recipe.cuisine.rawValue)
          .font(.secondaryText)
          .foregroundStyle(Color.gray)
      }
    }
  }

  @ViewBuilder
  private var recipeImage: some View {
    LoadableContentView(
      loadingState: self.viewModel.loadingImageDataState,
      content: { data in
        if let image = UIImage(data: data) {
          Image(uiImage: image)
            .resizable()
            .scaledToFill()
        } else {
          self.placeHolderImageView
        }
      }, failedContent: {
        self.placeHolderImageView
      }
    )
  }

  private var placeHolderImageView: some View {
    Color.gray
      .overlay {
        Image(systemName: "photo.fill")
      }
  }
}
