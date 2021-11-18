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
			List {
				ForEach(model.collectionCategories) { collection in
					NavigationLink {
						CollectionDetailView(collectionId: collection.id)
							.navigationTitle(collection.title)
					} label: {
						SubtitleView(title: collection.title, subtitle: collection.photosCount.description + " Photos")
							.padding(.vertical, 8)
					}
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
