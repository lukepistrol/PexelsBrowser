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
	
	public func fetchCollectionCategories(page: Int = 1, completion: @escaping (Array<CollectionCategory>) -> ()) {
		var req = URLRequest(url: URL(string: "https://api.pexels.com/v1/collections/featured?page=\(page)")!)
		req.setValue(Environment.APIKeys.pexels.key, forHTTPHeaderField: Environment.APIKeys.pexels.header)
		
		cancelable = URLSession.shared.dataTaskPublisher(for: req)
			.subscribe(on: Self.sessionProcessingQueue)
			.map({ return $0.data })
			.decode(type: CollectionCategoriesWrapper.self, decoder: JSONDecoder())
			.receive(on: DispatchQueue.main)
			.sink(receiveCompletion: { subCompletion in
				switch subCompletion {
				case .finished:
					break
				case .failure(let error):
					print(error)
				}
			}, receiveValue: { (wrapper) in
				completion(wrapper.collections)
			})
	}
	
	public func fetch(_ type: ViewModel.StreamType = .curated,
					  searchText query: String? = nil,
					  page: Int = 1, completion: @escaping (Array<Photo>) -> ()) {
		var url: URLComponents = url(for: type, collectionID: query ?? "")
		var param: Array<URLQueryItem> = [.init(name: "page", value: "\(page)"),
										  .init(name: "per_page", value: "80")]
		
		switch type {
		case .curated:
			break
		case .search:
			guard let query = query else { return }
			param.append(.init(name: "query", value: query))
			break
		case .collections:
			param.append(.init(name: "type", value: "photos"))
			break
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
					print(error)
				}
			}, receiveValue: { (wrapper) in
				completion(wrapper.photos ?? wrapper.media ?? [])
			})
	}
	
	private func url(for type: ViewModel.StreamType, collectionID: String) -> URLComponents {
		switch type {
		case .curated: return URLComponents(string: Environment.APIUrls.Pexels.curated)!
		case .search: return URLComponents(string: Environment.APIUrls.Pexels.search)!
		case .collections: return URLComponents(string: Environment.APIUrls.Pexels.collections + "/" + collectionID)!
		}
	}
	
	private func url(for type: ViewModel.StreamType) -> String {
		if type == .curated { return Environment.APIUrls.Pexels.curated }
		if type == .search { return Environment.APIUrls.Pexels.search }
		return ""
	}
}
