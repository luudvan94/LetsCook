//
//  RecipeFilteringTest.swift
//  RecipeSearchingTests
//
//  Created by Luu Van on 6/20/23.
//

import XCTest
@testable import RecipeSearching

extension Recipe {
	static func fixture(_ name: String = "") -> Recipe {
		return .init(name: name)
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
		let recipes = [Recipe.fixture("canh chua ca"), Recipe.fixture("ca chien nuoc mam"), Recipe.fixture("dau hu chien")]
		let filteredRecipes = recipeFiltering(recipes, by: keyword)
		XCTAssertTrue(filteredRecipes.count == 3)
	}

	func testNonEmptyKeywordReturnsFilteredRecipes() {
		let keyword = "ca"
		let recipes = [Recipe.fixture("canh chua ca"), Recipe.fixture("ca chien nuoc mam"), Recipe.fixture("dau hu chien")]
		let filteredRecipes = recipeFiltering(recipes, by: keyword)

		XCTAssertTrue(filteredRecipes.count == 2)
		XCTAssertTrue(filteredRecipes.first!.name == "canh chua ca")
	}

	func testNonEmptyKeywordWithWhiteSpaceReturnsFilteredRecipes() {
		let keyword = "canh chu"
		let recipes = [Recipe.fixture("canh chua ca"), Recipe.fixture("ca chien nuoc mam"), Recipe.fixture("dau hu chien")]
		let filteredRecipes = recipeFiltering(recipes, by: keyword)

		XCTAssertTrue(filteredRecipes.count == 1)
		XCTAssertTrue(filteredRecipes.first!.name == "canh chua ca")
	}
}
