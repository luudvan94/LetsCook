//
//  recipeFiltering.swift
//  RecipeSearching
//
//  Created by Luu Van on 6/20/23.
//

import Foundation

func recipeFiltering(_ recipes: [Recipe], by keyword: String) -> [Recipe] {
	guard !recipes.isEmpty && !keyword.isEmpty else {
		return recipes
	}

	let filteredRecipes = recipes.filter { $0.name.localizedCaseInsensitiveContains(keyword) }
	let sortedRecipes = filteredRecipes.sorted { recipe1, recipe2 in
		let count1 = countOccurrences(of: keyword, in: recipe1.name)
		let count2 = countOccurrences(of: keyword, in: recipe2.name)
		return count1 > count2
	}

	return sortedRecipes
}

func countOccurrences(of keyword: String, in text: String) -> Int {
	let components = text.components(separatedBy: CharacterSet.whitespacesAndNewlines)
	return components.filter { $0.localizedCaseInsensitiveContains(keyword) }.count
}
