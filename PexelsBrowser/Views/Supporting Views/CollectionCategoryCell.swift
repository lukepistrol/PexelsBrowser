//
//  CollectionCategoryCell.swift
//  PexelsBrowser
//
//  Created by Lukas Pistrol on 19.11.21.
//

import SwiftUI

struct CollectionCategoryCell: View {
	var collection: CollectionCategory
	
	var body: some View {
		NavigationLink {
			CollectionDetailView(collectionId: collection.id)
				.navigationTitle(collection.titleText)
		} label: {
			HStack {
				SubtitleView(title: collection.titleText, subtitle: collection.photosCount.description + " Photos")
					.padding(.vertical, 8)
			}
		}
		.listRowBackground(
			Rectangle()
				.cornerRadius(12)
				.foregroundColor(.white)
				.padding(4)
		)
		.listRowSeparator(.hidden)
	}
}
