//
//  RecipeSearchingScreen.swift
//  RecipeSearching
//
//  Created by Luu Van on 6/16/23.
//

import SwiftUI

public struct RecipeSearchingView: View {
	@StateObject private var viewModel = ViewModel()

	public init() {}

	public var body: some View {
		NavigationView {
			if case let .success(recipes) = viewModel.filteredRecipes {
				List {
					ForEach(recipes, id: \.self) { recipe in
						Text(recipe.name)
					}
				}
				.searchable(text: $viewModel.searchText) {
					ForEach(recipes, id: \.self) { recipe in
						Text(recipe.name)
					}
				}
			} else if case let .failure(error) = viewModel.filteredRecipes {
				VStack {
					Text("Error: \(error.localizedDescription)")
						.foregroundColor(.red)
						.padding()
				}
			}
		}
	}
}

struct RecipeSearchingScreen_Previews: PreviewProvider {
	static var previews: some View {
		RecipeSearchingView()
	}
}
