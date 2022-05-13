//
//  ViewModel.swift
//  PexelsBrowser
//
//  Created by Lukas Pistrol on 15.11.21.
//

import Foundation
import PexelsSwift
import UIKit
import CoreHaptics

class ViewModel: ObservableObject {
	
	@Published private (set) var curatedImages: Array<PSPhoto> = []
	@Published private (set) var searchImages: Array<PSPhoto> = []
	@Published private (set) var collectionImages: Array<PSPhoto> = []
	@Published private (set) var collectionCategories: Array<CollectionCategory> = []
	
	@Published var showNotification: Bool = false
	
	private (set) var notification: LPNotification? = nil {
		didSet {
			if let _ = notification { showNotification = true }
			else { showNotification = false }
		}
	}
	
	private var engine: CHHapticEngine?
	
	private var curatedPage = 1
	private var searchPage = 1
	private var categoriesPage = 1
	private var collectionPage = 1
	
	static let shared: ViewModel = .init()
	
	init() {
        PexelsSwift.shared.setAPIKey(Environment.APIKeys.pexels.key)
		getCuratedImages()
		prepareHaptics()
	}
	
	func setCuratedImages(_ photos: Array<PSPhoto>) {
		self.curatedImages = photos
	}
	
	func setSearchImages(_ photos: Array<PSPhoto>) {
		self.searchImages = photos
	}
	
	func setCollectionImages(_ photos: Array<PSPhoto>) {
		self.collectionImages = photos
	}
	
	func getSearchImages(_ query: String, nextPage: Bool = false) {
		if nextPage { searchPage += 1 } else { searchPage = 1 }
        Task {
            let results = await PexelsSwift.shared.getPhotos(search: query, page: searchPage)
            DispatchQueue.main.async {
                if self.searchPage == 1 {
                    self.searchImages = results
                } else {
                    self.searchImages.append(contentsOf: results)
                }
            }
        }
	}
	
	func getCuratedImages(nextPage: Bool = false) {
		if nextPage { curatedPage += 1 } else { curatedPage = 1 }
        Task {
            let results = await PexelsSwift.shared.getCuratedPhotos(page: curatedPage)
            DispatchQueue.main.async {
                if self.curatedPage == 1 {
                    self.curatedImages = results
                } else {
                    self.curatedImages.append(contentsOf: results)
                }
            }
		}
	}
	
	func getCollectionImages(for id: String, nextPage: Bool = false) {
		if nextPage { collectionPage += 1 } else { collectionPage = 1 }
        Task {
            let results = await PexelsSwift.shared.getPhotos(for: id, page: collectionPage)
            DispatchQueue.main.async {
                if self.collectionPage == 1 {
                    self.collectionImages = results
                } else {
                    self.collectionImages.append(contentsOf: results)
                }
            }
		}
	}
	
	func getCollectionCategories(nextPage: Bool = false) {
		if nextPage { categoriesPage += 1 } else { categoriesPage = 1 }
        Task {
            let results = await PexelsSwift.shared.getCategories(page: categoriesPage)
            DispatchQueue.main.async {
                if self.categoriesPage == 1 {
                    self.collectionCategories = results.filter { $0.photosCount > 0 }
                } else {
                    self.collectionCategories.append(contentsOf: results.filter { $0.photosCount > 0 })
                }
            }
		}
	}
	
	func save(image: PSPhoto) {
		if let data = try? Data(contentsOf: URL(string: image.source[PSPhoto.Size.original.rawValue]!)!) {
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
		case curated, search, collections
	}
}


extension ViewModel {
	
	func prepareHaptics() {
		guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
		
		do {
			self.engine = try CHHapticEngine()
			try engine?.start()
		} catch {
			print("There was an error creating the engine: \(error.localizedDescription)")
		}
	}
	
	func playHaptic() {
		let generator = UINotificationFeedbackGenerator()
		generator.notificationOccurred(.success)
	}
	
}








