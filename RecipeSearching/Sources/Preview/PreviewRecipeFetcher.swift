//
//  PreviewRecipeFetcher.swift
//  RecipeSearching
//
//  Created by Luu Van on 6/20/23.
//

import Foundation
import SharedUI

class PreviewRecipeFetcher: RecipeListFetcher, RecipeDetailFetcher {
	func fetchRecipes() async throws -> [Recipe] {
		do {
			let recipes: [Recipe] = try JSONReader.readJSONFromFile(
				named: "recipes",
				bundle: Bundle(for: PreviewRecipeFetcher.self)
			)
			return recipes
		} catch JSONReader.JSONReaderError.fileNotFound {
			print("Recipes.json not found in Preview folder.")
			throw NSError(
				domain: "PreviewRecipeFetcher",
				code: 0,
				userInfo: [NSLocalizedDescriptionKey: "Recipes.json not found in Preview folder."]
			)
		} catch JSONReader.JSONReaderError.readingError(let error) {
			print("Error reading Recipes.json: \(error.localizedDescription)")
			throw NSError(
				domain: "PreviewRecipeFetcher",
				code: 0,
				userInfo: [NSLocalizedDescriptionKey: "Error reading Recipes.json: \(error.localizedDescription)"]
			)
		}
	}

	func fetchDetails(for recipe: Recipe) async throws -> RecipeDetail {
		.fixture()
	}
}
