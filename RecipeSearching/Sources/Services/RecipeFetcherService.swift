//
//  UserDefaultRecipeFetcher.swift
//  RecipeSearching
//
//  Created by Luu Van on 6/20/23.
//

import Foundation
import Combine

protocol RecipeListFetcher {
	func fetchRecipes() async throws -> [Recipe]
}

protocol RecipeDetailFetcher {
	func fetchDetails(for recipe: Recipe) async throws -> RecipeDetail
}

struct RecipeFetcherService: RecipeListFetcher, RecipeDetailFetcher {
	func fetchRecipes() async throws -> [Recipe] {
		return []
	}

	func fetchDetails(for recipe: Recipe) async throws -> RecipeDetail {
		.fixture()
	}
}
