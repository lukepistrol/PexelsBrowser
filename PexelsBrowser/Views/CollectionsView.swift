//
//  CollectionsView.swift
//  PexelsBrowser
//
//  Created by Lukas Pistrol on 18.11.21.
//

import SwiftUI

struct CollectionsView: View {
	@StateObject private var model: ViewModel = .shared
	
    var body: some View {
		NavigationView {
			if model.collectionCategories.isEmpty {
				ProgressView()
					.navigationTitle("Collections")
			} else {
				List {
					ForEach(model.collectionCategories) { collection in
						CollectionCategoryCell(collection: collection)
					}
					Section {
						Button("More") {
							model.getCollectionCategories(nextPage: true)
						}
						.frame(maxWidth: .infinity)
						.buttonStyle(.bordered)
						.controlSize(.regular)
						.listRowBackground(Color.clear)
					}
				}
				.navigationTitle("Collections")
			}
		}.onAppear {
			model.getCollectionCategories()
		}
    }
}

struct CollectionsView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionsView()
			.previewDevice("iPhone 12")
    }
}
