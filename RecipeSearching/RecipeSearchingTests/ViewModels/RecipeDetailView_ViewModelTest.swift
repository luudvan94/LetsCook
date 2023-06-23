//
//  RecipeDetailView_ViewModelTest.swift
//  RecipeSearchingTests
//
//  Created by Luu Van on 6/22/23.
//

import XCTest
import Dependencies
import Combine
import SharedNetwork
@testable import RecipeSearching

// swiftlint:disable type_name
final class RecipeDetailView_ViewModelTest: XCTestCase {

	func testWhenStartFetchingDetails_RecipeDetailFetcherReceiveCorrectRecipe() async {
		let expectRecipe = Recipe.fixture("spaghetti")
		let spy = RecipeDetailFetcherSpy()
		let viewModel = withDependencies {
			$0.recipeDetailFetcher = spy
		} operation: {
			RecipeDetailView.ViewMode(recipe: expectRecipe)
		}

		await viewModel.fetchDetails()
		XCTAssertTrue(expectRecipe.name == spy.receivedRecipe?.name)
	}

	func testWhenFetchingSuccess_ViewModelDisplayCorrectRecipeDetail() async {
		let expected = RecipeDetail.fixture()
		let viewModel = withDependencies {
			$0.recipeDetailFetcher = RecipeDetailFetcherStub(result: .success(.fixture()))
		} operation: {
			RecipeDetailView.ViewMode(recipe: .fixture())
		}

		Task {
			await viewModel.fetchDetails()
		}

		let expectation = XCTestExpectation(description: "Received details")
		var received: RecipeDetail?

		let cancellable = viewModel.$recipeDetail.sink { result in
			if case let .success(details) = result {
				received = details
				expectation.fulfill()
			}
		}

		await fulfillment(of: [expectation], timeout: 1.0)
		XCTAssertEqual(received, expected)

		cancellable.cancel()
	}

	func testWhenFetchingFail_ViewModelDisplayCorrectError() async {
		let expected = NSError(domain: "test.domain", code: 123, userInfo: nil)
		let viewModel = withDependencies {
			$0.recipeDetailFetcher = RecipeDetailFetcherStub(result: .failure(expected))
		} operation: {
			RecipeDetailView.ViewMode(recipe: .fixture())
		}

		Task {
			await viewModel.fetchDetails()
		}

		let expectation = XCTestExpectation(description: "Received Error")
		var received: Error?

		let cancellable = viewModel.$recipeDetail.sink { result in
			if case let .failure(error) = result {
				received = error
				expectation.fulfill()
			}
		}

		await fulfillment(of: [expectation], timeout: 1.0)

		XCTAssertNotNil(received)
		XCTAssertEqual(received?.localizedDescription, expected.localizedDescription)

		cancellable.cancel()
	}
}
// swiftlint:enable type_name
