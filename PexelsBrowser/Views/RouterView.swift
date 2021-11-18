//
//  RouterView.swift
//  PexelsBrowser
//
//  Created by Lukas Pistrol on 15.11.21.
//

import SwiftUI

struct RouterView: View {
	
	@State private var selectedView: Environment.TabViewTag = .collections
	
	var body: some View {
		TabView(selection: $selectedView) {
			PopularView(selectedView: $selectedView)
				.tabItem { Label("Popular", systemImage: "sparkles") }
				.tag(Environment.TabViewTag.popular)
			CollectionsView()
				.tabItem {
					Label("Collections", systemImage: "text.below.photo")
				}
				.tag(Environment.TabViewTag.collections)
			SearchView()
				.tabItem { Label("Search", systemImage: "magnifyingglass") }
				.tag(Environment.TabViewTag.search)
		}
	}
}



struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		RouterView()
			.previewDevice("iPhone 12")
		
	}
}
