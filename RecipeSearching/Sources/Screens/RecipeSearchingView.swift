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
			if case .loading = viewModel.filteredRecipes {
				Text("loading")
			} else {
				if case let .success(recipes) = viewModel.filteredRecipes {
					List {
						ForEach(recipes, id: \.self) { recipe in
							NavigationLink {
								RecipeDetailView(viewModel: .init(recipe: recipe))
									.navigationTitle("Recipe Detail")
							} label: {
								Text(recipe.name)
							}
						}
					}
					.searchable(text: $viewModel.searchText) {
						ForEach(recipes, id: \.self) { recipe in
							NavigationLink {
								RecipeDetailView(viewModel: .init(recipe: recipe))
									.navigationTitle("Recipe Detail")
							} label: {
								Text(recipe.name)
							}
						}
					}
				}

				if case let .failure(error) = viewModel.filteredRecipes {
					VStack {
						Text("Error: \(error.localizedDescription)")
							.foregroundColor(.red)
							.padding()
					}
				}
			}
		}
		.task {
			await viewModel.fetchRecipes()
		}

	}
}

struct RecipeSearchingScreen_Previews: PreviewProvider {
	static var previews: some View {
		RecipeSearchingView()
	}
}
