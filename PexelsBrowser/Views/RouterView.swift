//
//  RouterView.swift
//  PexelsBrowser
//
//  Created by Lukas Pistrol on 15.11.21.
//

import SwiftUI

struct RouterView: View {
	
	@State private var selectedView: Int = 0
	
	var body: some View {
		TabView(selection: $selectedView) {
			PopularView(selectedView: $selectedView)
				.tabItem { Label("Popular", systemImage: "sparkles") }
				.tag(0)
			SearchView()
				.tabItem { Label("Search", systemImage: "magnifyingglass") }
				.tag(1)
		}
	}
}



struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		RouterView()
			.previewDevice("iPhone 12")
		
	}
}
