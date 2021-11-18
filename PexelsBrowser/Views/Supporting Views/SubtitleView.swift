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
	var spacing: Double = 4
	
	var body: some View {
		VStack(alignment: .leading, spacing: spacing) {
			Text(title)
				.font(.headline)
				.foregroundColor(.primary)
			if !subtitle.isEmpty {
				Text(subtitle)
					.bold()
					.font(.caption)
					.foregroundStyle(.secondary)
			}
		}
	}
}
