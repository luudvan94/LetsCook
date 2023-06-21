//
//  Recipe.swift
//  RecipeSearching
//
//  Created by Luu Van on 6/20/23.
//

import Foundation

public struct Recipe: Equatable, Decodable, Hashable {
	var name: String
}

extension Recipe {
	static func fixture(_ name: String = "") -> Recipe {
		return .init(name: name)
	}
}
