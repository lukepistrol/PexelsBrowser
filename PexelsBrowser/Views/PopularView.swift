//
//  PopularView.swift
//  PexelsBrowser
//
//  Created by Lukas Pistrol on 15.11.21.
//

import SwiftUI

struct PopularView: View {
	@Binding var selectedView: Int
	
	@StateObject private var model = ViewModel.shared
	
	var body: some View {
		NavigationView {
			ScrollView {
				LazyVStack(spacing: 0) {
					ForEach(model.curatedImages) { photo in
						PhotoCard(photo: photo)
							.onAppear {
								if photo == model.curatedImages.last {
									model.getCuratedImages(nextPage: true)
								}
							}
					}
				}
			}
			.navigationTitle("Popular")
			.toolbar(content: {
				ToolbarItem(placement: .navigationBarTrailing) {
					Button { selectedView = 1 } label: {
						Label("Search", systemImage: "magnifyingglass")
							.foregroundColor(.accentColor)
							.labelStyle(.iconOnly)
					}
				}
			})
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
	}
}
