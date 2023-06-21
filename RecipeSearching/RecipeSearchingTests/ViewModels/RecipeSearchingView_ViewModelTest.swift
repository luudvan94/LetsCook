//
//  RecipeSearchingView_ViewModelTest.swift
//  RecipeSearchingTests
//
//  Created by Luu Van on 6/16/23.
//

import XCTest
import Dependencies
import Combine
@testable import RecipeSearching

struct RecipeFetcherStub: RecipeFetcher {
	let result: Result<[Recipe], Error>

	init(_ result: Result<[Recipe], Error>) {
		self.result = result
	}

	func fetchRecipes() async throws -> [Recipe] {
		switch self.result {
		case .success(let recipes):
			return recipes
		case .failure(let error):
			throw error
		}
	}
}
// swiftlint:disable type_name
final class RecipeSearchingView_ViewModelTest: XCTestCase {
	func testWhenRecipeKeywordIsEmpty_DisplayAllSuggestedRecipes() {
		let expectedRecipes = Recipe.fixtureArray(from: ["canh chua ca", "ca chien nuoc mam", "dau hu chien"])
		let viewModel = withDependencies {
			$0.recipeFetcher = RecipeFetcherStub(.success(expectedRecipes))
		} operation: {
			RecipeSearchingView.ViewModel()
		}

		let expectation = XCTestExpectation(description: "Filter recipes")
		var filteredRecipes: [Recipe]?

		let cancellable = viewModel.$filteredRecipes.dropFirst().sink { result in
			if case let .success(recipes) = result {
				filteredRecipes = recipes
				expectation.fulfill()
			}
		}

		wait(for: [expectation], timeout: 1.0)

		XCTAssertEqual(filteredRecipes?.count, expectedRecipes.count)

		cancellable.cancel()
	}

	func testWhenFetchRecipesFailed_DisplayErrorMessage() {
		let expectedError = NSError(domain: "test.domain", code: 123, userInfo: nil)
		let viewModel = withDependencies {
			$0.recipeFetcher = RecipeFetcherStub(.failure(expectedError))
		} operation: {
			RecipeSearchingView.ViewModel()
		}

		let expectation = XCTestExpectation(description: "Display error message")
		var receivedError: Error?

		let cancellable = viewModel.$filteredRecipes.sink { result in
			if case let .failure(error) = result {
				receivedError = error
				expectation.fulfill()
			}
		}

		wait(for: [expectation], timeout: 1.0)

		XCTAssertNotNil(receivedError)
		XCTAssertEqual(receivedError?.localizedDescription, expectedError.localizedDescription)

		cancellable.cancel()
	}

	func testWhenRecipeKeywordIsNonEmpty_DisplaySuggestedFilteredRecipes() {
		let allRecipes = Recipe.fixtureArray(from: ["canh chua ca", "ca chien nuoc mam", "dau hu chien"])
		let searchText = "ca" // Example non-empty search text
		let expectedFilteredRecipes = recipeFiltering(allRecipes, by: searchText)

		let viewModel = withDependencies {
			$0.recipeFetcher = RecipeFetcherStub(.success(allRecipes))
		} operation: {
			let viewModel = RecipeSearchingView.ViewModel()
			viewModel.searchText = searchText
			return viewModel
		}

		let expectation = XCTestExpectation(description: "Filter recipes")
		var receivedFilteredRecipes: [Recipe]?

		let cancellable = viewModel.$filteredRecipes.dropFirst().sink { result in
			if case let .success(filteredRecipes) = result {
				receivedFilteredRecipes = filteredRecipes
				expectation.fulfill()
			}
		}

		wait(for: [expectation], timeout: 1.0)

		XCTAssertEqual(receivedFilteredRecipes, expectedFilteredRecipes)

		cancellable.cancel()
	}
}
// swiftlint:enable type_name
