//
//  RouterView.swift
//  PexelsBrowser
//
//  Created by Lukas Pistrol on 15.11.21.
//

import SwiftUI

struct RouterView: View {
	
	@State private var selectedView: Environment.TabViewTag = .curated
	
	var body: some View {
		TabView(selection: $selectedView) {
			PopularView(selectedView: $selectedView)
				.tabItem {
					Label("Curated", systemImage: "square.stack.3d.up")
						.environment(\.symbolVariants, selectedView == .curated ? .fill : .none)
				}
				.tag(Environment.TabViewTag.curated)
			CollectionsView()
				.tabItem {
					Label("Collections", systemImage: "tray.2")
						.environment(\.symbolVariants, selectedView == .collections ? .fill : .none)
				}
				.tag(Environment.TabViewTag.collections)
			SearchView()
				.tabItem {
					Label("Search", systemImage: "magnifyingglass")
						.environment(\.symbolVariants, selectedView == .search ? .fill : .none)
				}
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
