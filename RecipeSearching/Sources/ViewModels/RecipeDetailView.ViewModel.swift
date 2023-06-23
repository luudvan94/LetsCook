//
//  RecipeDetail.ViewModel.swift
//  RecipeSearching
//
//  Created by Luu Van on 6/21/23.
//

import Foundation
import Combine
import Dependencies
import SharedNetwork

extension RecipeDetailView {
	@MainActor
	class ViewMode: ObservableObject {
		@Dependency(\.recipeDetailFetcher) var recipeFetcher

		@Published var recipeDetail: RemoteData<RecipeDetail, Error> = .notAsked

		private var recipe: Recipe
		init(recipe: Recipe) {
			self.recipe = recipe
		}

		func fetchDetails() async {
			do {
				self.recipeDetail = .loading
				let details = try await recipeFetcher.fetchDetails(for: self.recipe)
				self.recipeDetail = .success(details)
			} catch {
				self.recipeDetail = .failure(error)
			}
		}
	}
}
