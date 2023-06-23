//
//  RecipeFetcherStub.swift
//  RecipeSearching
//
//  Created by Luu Van on 6/22/23.
//

import Foundation
@testable import RecipeSearching

struct RecipeFetcherStub: RecipeListFetcher {
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
