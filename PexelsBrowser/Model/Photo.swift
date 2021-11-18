//
//  Photo.swift
//  PexelsBrowser
//
//  Created by Lukas Pistrol on 15.11.21.
//

import Foundation

struct Photo: Identifiable, Codable, Equatable {
	
	public var id: Int
	public var url: String
	
	public var width: Int
	public var height: Int
	
	public var src: Dictionary<Size.RawValue,String>
	
	public var avgColor: String { return avg_color }
	
	public var photographer: String
	
	private var photographer_url: String
	private var photographer_id: Int
	private var avg_color: String
	
	enum Size: String {
		case original, large2x, large, medium, small, portrait, landscape, tiny
	}
	
}
