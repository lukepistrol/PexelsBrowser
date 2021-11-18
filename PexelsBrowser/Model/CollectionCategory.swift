//
//  CollectionCategory.swift
//  PexelsBrowser
//
//  Created by Lukas Pistrol on 18.11.21.
//

import Foundation

struct CollectionCategory: Identifiable, Codable, Equatable {
	
	var id: String
	var description: String
	
	public var titleText: String { title.trimmingCharacters(in: .whitespaces) }
	public var photosCount: Int { photos_count }
	
	private var title: String
	private var media_count: Int
	private var photos_count: Int
	private var videos_count: Int

}
