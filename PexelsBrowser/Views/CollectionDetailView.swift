//
//  CollectionDetailView.swift
//  PexelsBrowser
//
//  Created by Lukas Pistrol on 18.11.21.
//

import SwiftUI

struct CollectionDetailView: View {
	@StateObject private var model = ViewModel.shared
	
	@State var collectionId: String
	
	var body: some View {
		ScrollView {
			LazyVStack(spacing: 0) {
				ForEach(model.collectionImages) { photo in
					PhotoCard(photo: photo)
						.onAppear {
							if photo == model.collectionImages.last {
								model.getCollectionImages(for: collectionId, nextPage: true)
							}
						}
				}
			}
		}
		.alert(model.notification?.title ?? "", isPresented: $model.showNotification, actions: {
			Button("Dismiss") {
				model.removeNotification()
			}
		}, message: {
			VStack {
				Text(model.notification?.message ?? "")
			}
		})
		.onAppear {
			model.getCollectionImages(for: collectionId)
		}
		.onDisappear {
			model.setCollectionImages([])
		}
	}
}
