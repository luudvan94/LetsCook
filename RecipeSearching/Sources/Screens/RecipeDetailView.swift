//
//  RecipeDetailView.swift
//  RecipeSearching
//
//  Created by Luu Van on 6/21/23.
//

import SwiftUI

public struct RecipeDetailView: View {
	@ObservedObject var viewModel: RecipeDetailView.ViewMode

	public var body: some View {
		ScrollView {
			if case .loading = viewModel.recipeDetail {
				ProgressView()
			}

			if case let .success(recipe) = viewModel.recipeDetail {
				VStack(alignment: .leading) {
					// Display recipe information
					Text(recipe.name)
						.font(.title)
						.padding(.top)
					Text("Cooking Time: \(recipe.cookingTime) minutes")
					Text("Servings: \(recipe.servings)")
					Text("Difficulty: \(recipe.difficulty)")

					// Display ingredients
					GroupBox(label: Text("Ingredients").font(.headline)) {
						ForEach(recipe.ingredients, id: \.self) { ingredient in
							HStack {
								Text(ingredient)
								Spacer()
							}
						}
					}
					.padding()

					// Display instructions
					GroupBox(label: Text("Instructions").font(.headline)) {
						ForEach(recipe.instructions.indices, id: \.self) { index in
							HStack {
								Text("Step \(index+1): \(recipe.instructions[index])")
								Spacer()
							}
							.padding(.vertical)
						}
					}
					.padding()
				}
				.padding()
			}

			if case let .failure(error) = viewModel.recipeDetail {
				Text(error.localizedDescription)
			}
		}
		.navigationBarTitleDisplayMode(.large)
		.task {
			await viewModel.fetchDetails()
		}
	}
}

struct RecipeDetailView_Previews: PreviewProvider {
	static var previews: some View {
		RecipeDetailView(viewModel: .init(recipe: .init(name: "Spaghetti")))
	}
}
