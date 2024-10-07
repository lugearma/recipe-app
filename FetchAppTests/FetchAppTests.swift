//
//  FetchAppTests.swift
//  FetchAppTests
//
//  Created by Luis Arias on 07/10/24.
//

import Testing
@testable import FetchRecipeApp

struct FetchAppTests {
  @Test func testLoadingWithValidRecipes() async throws {
    let mockService = MockService(fileLoader: FileContentLoader(fileName: "valid-recipes-mock-response"))
    let viewModel = await RecipeListViewModel(service: mockService)
    await viewModel.loadRecipes()

    guard case .loaded(let listState) = await viewModel.loadingState,
          case .filled(let recipes) = listState else {
      #expect(Bool(false))
      return
    }

    #expect(recipes.count > 0)
  }

  @Test func testLoadingWithEmptyRecipes() async throws {
    let mockService = MockService(fileLoader: FileContentLoader(fileName: "empty-recipes-mock-response"))
    let viewModel = await RecipeListViewModel(service: mockService)
    await viewModel.loadRecipes()

    guard case .loaded(let listState) = await viewModel.loadingState,
          case .empty = listState else {
      #expect(Bool(false))
      return
    }

    #expect(true)
  }

  @Test func testLoadingWithMalformedRecipes() async throws {
    let mockService = MockService(fileLoader: FileContentLoader(fileName: "malformed-recipes-mock-response"))
    let viewModel = await RecipeListViewModel(service: mockService)
    await viewModel.loadRecipes()

    guard case .failed = await viewModel.loadingState else {
      #expect(Bool(false))
      return
    }

    #expect(true)
  }

  @Test func testLoadingImage() async throws {
    let mockService = MockService(fileLoader: FileContentLoader(fileName: "valid-recipes-mock-response"))
    let viewModel = await RecipeListViewModel(service: mockService)
    await viewModel.loadRecipes()

    guard case .loaded(let listState) = await viewModel.loadingState,
          case .filled(let recipes) = listState else {
      #expect(Bool(false))
      return
    }

    guard let recipeViewModel = recipes.first else {
      #expect(Bool(false))
      return
    }

    guard case .idle = await recipeViewModel.loadingImageDataState else {
      #expect(Bool(false))
      return
    }

    await recipeViewModel.loadImageData()

    guard case .loaded = await recipeViewModel.loadingImageDataState else {
      #expect(Bool(false))
      return
    }

    #expect(true)
  }
}
