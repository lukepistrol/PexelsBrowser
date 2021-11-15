//
//  APIRequest.swift
//  PexelsBrowser
//
//  Created by Lukas Pistrol on 15.11.21.
//

import Foundation
import Combine

class APIRequest {
	static let shared: APIRequest = .init()
	
	private var cancelable: AnyCancellable?
	
	private static let sessionProcessingQueue = DispatchQueue(label: "SessionProcessingQueue")
	
	public func fetch(_ type: ViewModel.StreamType = .curated, searchText query: String? = nil) {
		if type == .search {
			fetch(query != nil ?
					.search : .curated,
				  query: query ?? "")
		} else {
			fetch(.curated, query: "")
		}
	}
	
	private func fetch(_ type: ViewModel.StreamType, query: String) {
		var request = URLRequest(url: URL(string: "\(url(for: type))\(query.percentEncoded)")!)
		
		request.setValue(Environment.APIKeys.pexels.key, forHTTPHeaderField: Environment.APIKeys.pexels.header)
		
		cancelable = URLSession.shared.dataTaskPublisher(for: request)
			.subscribe(on: Self.sessionProcessingQueue)
			.map({ return $0.data })
			.decode(type: ResultsWrapper.self, decoder: JSONDecoder())
			.receive(on: DispatchQueue.main)
			.sink(receiveCompletion: { subCompletion in
				switch subCompletion {
				case .finished:
					break
				case .failure(let error):
					print(error.localizedDescription)
				}
			}, receiveValue: { (wrapper) in
				if type == .curated {
					ViewModel.shared.setCuratedPhotos(wrapper.photos)
				}
				if type == .search {
					ViewModel.shared.setSearchResults(wrapper.photos)
				}
			})
	}
	
	private func url(for type: ViewModel.StreamType) -> String {
		if type == .curated { return Environment.APIUrls.Pexels.curated }
		if type == .search { return Environment.APIUrls.Pexels.search }
		return ""
	}
}
