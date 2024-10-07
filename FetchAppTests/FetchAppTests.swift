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
    TestURL.currentTestURL = .valid
    let viewModel = await RecipeListViewModel()
    await viewModel.loadRecipes()

    guard case .loaded(let listState) = await viewModel.loadingState,
          case .filled(let recipes) = listState else {
      #expect(Bool(false))
      return
    }

    #expect(recipes.count > 0)
  }

  @Test func testLoadingWithEmptyRecipes() async throws {
    TestURL.currentTestURL = .empty
    let viewModel = await RecipeListViewModel()
    await viewModel.loadRecipes()

    guard case .loaded(let listState) = await viewModel.loadingState,
          case .empty = listState else {
      #expect(Bool(false))
      return
    }

    #expect(true)
  }

  @Test func testLoadingWithMalformedRecipes() async throws {
    TestURL.currentTestURL = .malformed
    let viewModel = await RecipeListViewModel()
    await viewModel.loadRecipes()

    guard case .failed = await viewModel.loadingState else {
      #expect(Bool(false))
      return
    }

    #expect(true)
  }
}
