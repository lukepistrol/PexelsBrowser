//
//  CollectionCategory.swift
//  PexelsBrowser
//
//  Created by Lukas Pistrol on 18.11.21.
//

import Foundation

struct CollectionCategory: Identifiable, Codable, Equatable {
	
	var id: String
	var title: String
	var description: String
	
	public var photosCount: Int { photos_count }
	
	private var media_count: Int
	private var photos_count: Int
	private var videos_count: Int

}
