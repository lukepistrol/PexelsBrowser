//
//  SubtitleView.swift
//  PexelsBrowser
//
//  Created by Lukas Pistrol on 15.11.21.
//

import SwiftUI

struct SubtitleView: View {
	var title: String
	var subtitle: String
	
	var body: some View {
		VStack(alignment: .leading) {
			Text(title)
				.font(.headline)
				.foregroundColor(.primary)
			Text(subtitle)
				.bold()
				.font(.caption)
				.foregroundStyle(.secondary)
		}
	}
}
