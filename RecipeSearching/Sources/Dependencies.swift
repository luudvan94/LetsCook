//
//  Dependencies.swift
//  RecipeSearching
//
//  Created by Luu Van on 6/21/23.
//

import Foundation
import Dependencies

private enum RecipeListFetcherKey: DependencyKey {
	static var liveValue: any RecipeListFetcher = PreviewRecipeFetcher()
	static var previewValue: any RecipeListFetcher = PreviewRecipeFetcher()
}

private enum RecipeDetailFetcherKey: DependencyKey {
	static var liveValue: any RecipeDetailFetcher = PreviewRecipeFetcher()
	static var previewValue: any RecipeDetailFetcher = PreviewRecipeFetcher()
}

extension DependencyValues {
	var recipeFetcher: RecipeListFetcher {
		get { self[RecipeListFetcherKey.self] }
		set { self[RecipeListFetcherKey.self] = newValue }
	}

	var recipeDetailFetcher: RecipeDetailFetcher {
		get { self[RecipeDetailFetcherKey.self] }
		set { self[RecipeDetailFetcherKey.self] = newValue }
	}
}
