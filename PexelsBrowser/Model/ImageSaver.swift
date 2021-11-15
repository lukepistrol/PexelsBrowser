//
//  ImageSaver.swift
//  PexelsBrowser
//
//  Created by Lukas Pistrol on 15.11.21.
//

import Foundation
import UIKit

class ImageSaver: NSObject {
	func writeToPhotoAlbum(image: UIImage) {
		UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
	}
	
	@objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
		ViewModel.shared.displayNotification(title: "Success!", message: "Photo saved sucessfully!")
	}
}
