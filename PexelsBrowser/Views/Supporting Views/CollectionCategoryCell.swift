//
//  CollectionCategoryCell.swift
//  PexelsBrowser
//
//  Created by Lukas Pistrol on 19.11.21.
//

import SwiftUI
import Pexels_Swift

struct CollectionCategoryCell: View {
	var collection: CollectionCategory
	
	var body: some View {
		NavigationLink {
			CollectionDetailView(collectionId: collection.id)
                .navigationTitle(collection.title)
		} label: {
			HStack {
				SubtitleView(title: collection.title, subtitle: collection.photosCount.description + " Photos")
					.padding(.vertical, 8)
			}
		}
		.listRowBackground(
			Rectangle()
				.cornerRadius(12)
				.foregroundStyle(.thickMaterial)
				.padding(4)
		)
		.listRowSeparator(.hidden)
	}
}
