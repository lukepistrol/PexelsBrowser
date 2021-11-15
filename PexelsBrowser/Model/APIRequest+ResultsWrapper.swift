//
//  APIRequest+ResultsWrapper.swift
//  PexelsBrowser
//
//  Created by Lukas Pistrol on 15.11.21.
//

import Foundation

extension APIRequest {
	struct ResultsWrapper: Codable {
		var photos: Array<Photo>
		var page: Int
		var per_page: Int
		var total_results: Int
		var prev_page: String?
		var next_page: String?
	}
}
