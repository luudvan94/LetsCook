//
//  UserDefaultRecipeFetcher.swift
//  RecipeSearching
//
//  Created by Luu Van on 6/20/23.
//

import Foundation
import Combine
import Dependencies

struct LiveRecipeFetcher: RecipeFetcher {
	func fetchRecipes() async throws -> [Recipe] {
		return []
	}
}

private enum RecipeFetcherKey: DependencyKey {
	static var liveValue: any RecipeFetcher = PreviewRecipeFetcher()
	static var previewValue: any RecipeFetcher = PreviewRecipeFetcher()
}

extension DependencyValues {
	var recipeFetcher: RecipeFetcher {
		get { self[RecipeFetcherKey.self] }
		set { self[RecipeFetcherKey.self] = newValue }
	}
}
