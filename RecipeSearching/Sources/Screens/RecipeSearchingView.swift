//
//  RecipeSearchingScreen.swift
//  RecipeSearching
//
//  Created by Luu Van on 6/16/23.
//

import SwiftUI

public struct RecipeSearchingView: View {
	@StateObject private var viewModel = RecipeSearchingView.ViewModel.init()

	public init() {}

	public var body: some View {
		NavigationView {
			List {
				ForEach(1...10, id: \.self) { index in
					Text("Item \(index)")
				}
			}
			.searchable(text: $viewModel.searchText) {
				ForEach(1...10, id: \.self) { index in
					Text("Item \(index)")
						.searchCompletion("Item \(index)")
				}
			}
			.navigationTitle("My Screen")
		}
	}
}

struct RecipeSearchingScreen_Previews: PreviewProvider {
	static var previews: some View {
		RecipeSearchingView()
	}
}
