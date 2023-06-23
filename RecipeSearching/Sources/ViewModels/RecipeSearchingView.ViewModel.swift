//
//  RecipeSearchingView.ViewModel.swift
//  RecipeSearching
//
//  Created by Luu Van on 6/16/23.
//

import Foundation
import Combine
import Dependencies
import SharedNetwork

extension RecipeSearchingView {
	@MainActor
	class ViewModel: ObservableObject {
		@Dependency(\.recipeFetcher) var recipeFetcher
		@Published var searchText = ""
		@Published var filteredRecipes: RemoteData<[Recipe], Error> = .notAsked

		private var allRecipes = [Recipe]()
		private var cancellables = Set<AnyCancellable>()

		init(recipeFiltering: @escaping ([Recipe], String) -> [Recipe] = recipeFiltering) {
			$searchText
				.dropFirst()
				.debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
				.sink { [weak self] text in
					guard let self = self else { return }
					self.filterRecipes(with: text, allRecipes: self.allRecipes, using: recipeFiltering)
				}
				.store(in: &cancellables)
		}

		func fetchRecipes() async {
			do {
				self.filteredRecipes = .loading
				let allRecipes = try await recipeFetcher.fetchRecipes()
				self.allRecipes = allRecipes
				self.filterRecipes(with: self.searchText, allRecipes: allRecipes, using: recipeFiltering)
			} catch {
				self.filteredRecipes = .failure(error)
			}
		}

		private func filterRecipes(
			with searchText: String,
			allRecipes: [Recipe],
			using recipeFiltering: @escaping ([Recipe], String) -> [Recipe]
		) {
			let filteredRecipes = recipeFiltering(allRecipes, searchText)
			self.filteredRecipes = .success(filteredRecipes)
		}
	}
}
