//
//  PopularView.swift
//  PexelsBrowser
//
//  Created by Lukas Pistrol on 15.11.21.
//

import SwiftUI
import LPColorUI

struct PopularView: View {
	@Binding var selectedView: Environment.TabViewTag
	
	@StateObject private var model = ViewModel.shared
	
	var body: some View {
		NavigationView {
			if model.curatedImages.isEmpty {
				ProgressView()
					.navigationTitle("Popular")
			} else {
				ScrollView {
					LazyVStack(spacing: 0) {
						ForEach(model.curatedImages) { photo in
							PhotoCard(photo: photo)
								.onAppear {
									if photo == model.curatedImages.last {
										model.getCuratedImages(nextPage: true)
									}
								}
								.foregroundColor(Color.separator)
						}
					}
				}
				.navigationTitle("Popular")
				.toolbar(content: {
					ToolbarItem(placement: .navigationBarTrailing) {
						Button { selectedView = .search } label: {
							Label("Search", systemImage: "magnifyingglass")
								.foregroundColor(.accentColor)
								.labelStyle(.iconOnly)
						}
					}
				})
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
	}
}
