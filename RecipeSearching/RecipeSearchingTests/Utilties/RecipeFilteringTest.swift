//
//  RecipeFilteringTest.swift
//  RecipeSearchingTests
//
//  Created by Luu Van on 6/20/23.
//

import XCTest
@testable import RecipeSearching

extension Recipe {
	static func fixtureArray(from names: [String]) -> [Recipe] {
		return names.map { Recipe.init(name: $0) }
	}
}

final class RecipeFilteringTest: XCTestCase {
	func testEmptyRecipesReturnsEmptyResult() {
		let keyword = ""
		let recipes = [Recipe]()
		let filteredRecipes = recipeFiltering(recipes, by: keyword)
		XCTAssertTrue(filteredRecipes.isEmpty)
	}

	func testEmptyKeywordReturnsAllRecipes() {
		let keyword = ""
		let recipes = Recipe.fixtureArray(from: ["canh chua ca", "ca chien nuoc mam", "dau hu chien"])
		let filteredRecipes = recipeFiltering(recipes, by: keyword)
		XCTAssertTrue(filteredRecipes.count == 3)
	}

	func testNonEmptyKeywordReturnsFilteredRecipes() {
		let keyword = "ca"
		let recipes = Recipe.fixtureArray(from: ["canh chua ca", "ca chien nuoc mam", "dau hu chien"])
		let filteredRecipes = recipeFiltering(recipes, by: keyword)

		XCTAssertTrue(filteredRecipes.count == 2)
		XCTAssertTrue(filteredRecipes.first!.name == "canh chua ca")
	}

	func testNonEmptyKeywordWithWhiteSpaceReturnsFilteredRecipes() {
		let keyword = "canh chu"
		let recipes = Recipe.fixtureArray(from: ["canh chua ca", "ca chien nuoc mam", "dau hu chien"])
		let filteredRecipes = recipeFiltering(recipes, by: keyword)

		XCTAssertTrue(filteredRecipes.count == 1)
		XCTAssertTrue(filteredRecipes.first!.name == "canh chua ca")
	}
}
