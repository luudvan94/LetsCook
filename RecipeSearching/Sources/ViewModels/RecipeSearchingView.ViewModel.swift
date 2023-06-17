//
//  RecipeSearchingView.ViewModel.swift
//  RecipeSearching
//
//  Created by Luu Van on 6/16/23.
//

import Foundation
import Combine

extension RecipeSearchingView {
	class ViewModel: ObservableObject {
		@Published var searchText = ""

		private var cancellables = Set<AnyCancellable>()

		init() {
			// You can perform additional actions based on the searchText changes
			$searchText
				.sink { text in
					// Perform search or any other action here
					print("Search text: \(text)")
				}
				.store(in: &cancellables)
		}
	}
}
