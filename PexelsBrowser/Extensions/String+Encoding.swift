//
//  String+Encoding.swift
//  PexelsBrowser
//
//  Created by Lukas Pistrol on 15.11.21.
//

import Foundation


extension String {
	
	var percentEncoded: String {
		self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
	}
	
}
