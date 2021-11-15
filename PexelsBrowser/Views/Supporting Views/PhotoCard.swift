//
//  PhotoCard.swift
//  PexelsBrowser
//
//  Created by Lukas Pistrol on 15.11.21.
//

import SwiftUI

struct PhotoCard: View {
	@StateObject private var model = ViewModel.shared
	
	var photo: Photo
	
	@State private var showDetails: Bool = false
	@State private var downloading: Bool = false
	
	var body: some View {
		Group {
			ZStack(alignment: .bottom) {
				image
				detailBox
			}
			.clipShape(RoundedRectangle(cornerRadius: 12))
		}
		.shadow(color: .black.opacity(0.2), radius: 12, x: 0, y: 4)
		.padding(.horizontal, 20)
		.padding(.bottom, 20)
		.onChange(of: model.showNotification) { newValue in
			if newValue == true {
				downloading = false
			}
		}
	}
	
	var detailBox: some View {
		HStack(spacing: 12) {
			HStack {
				SubtitleView(title: photo.photographerName, subtitle: "Artist")
				Spacer()
				Button {
					downloading = true
					Task {
						model.save(image: photo)
					}
				} label: {
					if downloading {
						ProgressView()
					} else {
						Label("Save", systemImage: "arrow.down")
							.font(.headline)
					}
				}
				.frame(height: 32)
				.padding(.horizontal, 12)
				.background(Capsule().foregroundStyle(.regularMaterial))
			}
			.offset(x: 0, y: showDetails ? 0 : 70)
			.opacity(showDetails ? 1 : 0)
			
			Button {
				withAnimation(.spring(response: 0.3, dampingFraction: 0.7, blendDuration: 1)) {
					showDetails.toggle()
				}
			} label: {
				Image(systemName: "plus")
					.rotationEffect(showDetails ? .degrees(-135) : .zero)
					.font(.headline)
			}
			.frame(width: 32, height: 32)
			.background(Circle().foregroundStyle(showDetails ? .regularMaterial : .ultraThickMaterial))
		}
		.frame(maxWidth: .infinity, alignment: .leading)
		.padding()
		.background(Rectangle()
						.cornerRadius(12)
						.foregroundStyle(.thinMaterial)
						.offset(x: 0, y: showDetails ? 0 : 70)
						.opacity(showDetails ? 1 : 0))
	}
	
	
	var image: some View {
		AsyncImage(url: URL(string: photo.src[Photo.Size.large2x.rawValue]!),
				   transaction: Transaction(animation: .easeInOut)) { phase in
			switch phase {
			case .empty:
				ZStack {
					Rectangle().foregroundColor(.white)
					ProgressView()
				}.aspectRatio(Double(photo.width)/Double(photo.height), contentMode: .fit)
			case .success(let image):
				image
					.resizable()
					.aspectRatio(Double(photo.width)/Double(photo.height), contentMode: .fit)
					.transition(.scale(scale: 1.05, anchor: .center).combined(with: .opacity).animation(.easeInOut))
			case .failure(_):
				Image(systemName: "wifi.slash")
			@unknown default: EmptyView()
			}
		}
		.frame(maxWidth: .infinity)
	}
}

