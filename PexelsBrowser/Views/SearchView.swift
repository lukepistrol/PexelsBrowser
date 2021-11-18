//
//  SearchView.swift
//  PexelsBrowser
//
//  Created by Lukas Pistrol on 15.11.21.
//

import SwiftUI

struct SearchView: View {
	@StateObject private var model = ViewModel.shared
	
	@State private var searchText: String = ""
	
	var body: some View {
		NavigationView {
			ScrollView {
				LazyVStack(spacing: 0) {
					ForEach(model.searchImages) { photo in
						PhotoCard(photo: photo)
							.onAppear {
								if photo == model.searchImages.last {
									model.getSearchImages(searchText, nextPage: true)
								}
							}
					}
				}
			}
			.navigationTitle("Search")
			.searchable(text: $searchText, placement: .navigationBarDrawer, prompt: "Search")
			.onSubmit(of: .search) {
				model.getSearchImages(searchText)
			}
			.onChange(of: searchText) { newValue in
				if searchText.isEmpty {
					model.setSearchImages([])
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
}
