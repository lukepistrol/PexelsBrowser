//
//  RouterView.swift
//  PexelsBrowser
//
//  Created by Lukas Pistrol on 15.11.21.
//

import SwiftUI

struct RouterView: View {
	var body: some View {
		TabView {
			PopularView()
				.tabItem { Label("Popular", systemImage: "sparkles") }
			SearchView()
				.tabItem { Label("Search", systemImage: "magnifyingglass") }
		}
	}
}



struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		RouterView()
			.previewDevice("iPhone 12")
		
	}
}
