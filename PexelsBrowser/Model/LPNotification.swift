//
//  LPNotification.swift
//  PexelsBrowser
//
//  Created by Lukas Pistrol on 15.11.21.
//

import Foundation

struct LPNotification: Identifiable {
	var id: UUID = UUID()
	var title: String
	var message: String
}
