//
//  ViewModel.swift
//  PexelsBrowser
//
//  Created by Lukas Pistrol on 15.11.21.
//

import Foundation
import UIKit

class ViewModel: ObservableObject {
	
	@Published private (set) var curatedPhotos: Array<Photo> = []
	@Published private (set) var searchResults: Array<Photo> = []
	
	@Published var showNotification: Bool = false
	
	private (set) var notification: LPNotification? = nil {
		didSet {
			if let _ = notification { showNotification = true }
			else { showNotification = false }
		}
	}
	
	static let shared: ViewModel = .init()
	
	init() {
		curatedImages()
	}
	
	func setCuratedPhotos(_ photos: Array<Photo>) {
		self.curatedPhotos = photos
	}
	
	func setSearchResults(_ photos: Array<Photo>) {
		self.searchResults = photos
	}
	
	func searchImages(_ query: String) {
		APIRequest.shared.fetch(.search, searchText: query)
	}
	
	func curatedImages() {
		APIRequest.shared.fetch()
	}
	
	func save(image: Photo) {
		if let data = try? Data(contentsOf: URL(string: image.src[Photo.Size.original.rawValue]!)!) {
			if let image = UIImage(data: data) {
				ImageSaver().writeToPhotoAlbum(image: image)
			}
		}
	}
	
	func displayNotification(title: String, message: String) {
		let noti = LPNotification(title: title, message: message)
		self.notification = noti
	}
	
	func removeNotification() {
		self.notification = nil
	}
	
	enum StreamType: String {
		case curated, search
	}
}









