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
	
	public func fetch(_ type: ViewModel.StreamType = .curated,
					  searchText query: String? = nil,
					  page: Int = 1, completion: @escaping (Array<Photo>) -> ()) {
		var url: URLComponents = url(for: type)
		var param: Array<URLQueryItem> = [.init(name: "page", value: "\(page)")]
		
		switch type {
		case .curated:
			break
		case .search:
			guard let query = query else { return }
			param.append(.init(name: "query", value: query))
		}
		
		url.queryItems = param
		guard let url = url.url else { return }
		fetch(url) { results in
			completion(results)
		}
	}
	
	private func fetch(_ url: URL,
					   completion: @escaping (Array<Photo>) -> ()) {
		var req = URLRequest(url: url)
		req.setValue(Environment.APIKeys.pexels.key, forHTTPHeaderField: Environment.APIKeys.pexels.header)
		
		cancelable = URLSession.shared.dataTaskPublisher(for: req)
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
				completion(wrapper.photos)
			})
	}
	
	private func url(for type: ViewModel.StreamType) -> URLComponents {
		switch type {
		case .curated: return URLComponents(string: Environment.APIUrls.Pexels.curated)!
		case .search: return URLComponents(string: Environment.APIUrls.Pexels.search)!
		}
	}
	
	private func url(for type: ViewModel.StreamType) -> String {
		if type == .curated { return Environment.APIUrls.Pexels.curated }
		if type == .search { return Environment.APIUrls.Pexels.search }
		return ""
	}
}
