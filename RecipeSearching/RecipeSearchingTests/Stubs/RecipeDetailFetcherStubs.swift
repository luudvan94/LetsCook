//
//  RecipeDetailFetcherFake.swift
//  RecipeSearchingTests
//
//  Created by Luu Van on 6/22/23.
//

import Foundation
import SharedNetwork
@testable import RecipeSearching

final class RecipeDetailFetcherSpy: RecipeDetailFetcher {
	private(set) var receivedRecipe: Recipe?

	func fetchDetails(for recipe: Recipe) async throws -> RecipeDetail {
		self.receivedRecipe = recipe
		return .fixture()
	}
}

final class RecipeDetailFetcherStub: RecipeDetailFetcher {
	private var result: RemoteData<RecipeDetail, Error>

	init(result: RemoteData<RecipeDetail, Error>) {
		self.result = result
	}

	func fetchDetails(for recipe: Recipe) async throws -> RecipeDetail {
		return try result.get()
	}
}
