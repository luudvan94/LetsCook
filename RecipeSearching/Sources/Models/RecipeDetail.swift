//
//  RecipeDetail.swift
//  RecipeSearching
//
//  Created by Luu Van on 6/21/23.
//

import Foundation

struct RecipeDetail: Decodable, Equatable {
	var name: String
	var cookingTime: Int
	var servings: Int
	var difficulty: String
	var ingredients: [String]
	var instructions: [String]
}

extension RecipeDetail {
	static func fixture() -> Self {
		.init(
			name: "Spaghetti Bolognese",
			cookingTime: 45,
			servings: 4,
			difficulty: "Medium",
			ingredients: [
				"400g Spaghetti",
				"2 tbsp Olive Oil",
				"1 Onion, chopped",
				"2 cloves Garlic, minced",
				"400g Ground Beef",
				"1 can Chopped Tomatoes",
				"Salt and Pepper to taste",
				"Grated Parmesan Cheese"
			],
			instructions: [
				"Boil the spaghetti according to the package instructions.",
				"While the spaghetti is cooking, heat the olive oil in a pan.",
				"Add the onion and garlic to the pan and cook until soft.",
				"Add the ground beef to the pan and cook until browned.",
				"Add the chopped tomatoes, salt, and pepper to the pan and simmer for 20 minutes.",
				"Drain the spaghetti and serve topped with the sauce and a sprinkling of Parmesan cheese."
			]
		)
	}
}
