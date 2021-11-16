//
//  Photo.swift
//  PexelsBrowser
//
//  Created by Lukas Pistrol on 15.11.21.
//

import Foundation

struct Photo: Identifiable, Codable, Equatable {
	
	var id: Int
	var url: String
	
	var width: Int
	var height: Int
	
	var src: Dictionary<Size.RawValue,String>
	
	private var photographer: String?
	private var photographerUrl: String?
	private var photographerId: Int?
	
	private var avgColor: String?
	
	public var photographerName: String { self.photographer ?? "" }
	
	enum Size: String {
		case original, large2x, large, medium, small, portrait, landscape, tiny
	}
	
}
