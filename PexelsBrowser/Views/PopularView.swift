//
//  PopularView.swift
//  PexelsBrowser
//
//  Created by Lukas Pistrol on 15.11.21.
//

import SwiftUI

struct PopularView: View {
	@StateObject private var model = ViewModel.shared
	
	var body: some View {
		NavigationView {
			ScrollView {
				VStack(spacing: 0) {
					ForEach(model.curatedPhotos) { photo in
						PhotoCard(photo: photo)
					}
				}
			}
			.navigationTitle("Popular")
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
