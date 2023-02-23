//
//  ContentView.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 2/2/23.
//

import SwiftUI

enum TabItem {
  case discover, purchased, search, setting //, account

}

struct ContentView: View {
    @State private var selection: TabItem = .purchased
    
    var body: some View {
        TabView(selection: $selection) {
            DiscoverView()
                .tabItem {
                    Label("Discover", systemImage: "star.fill")
                }
                .tag(TabItem.discover)
            
            BookstoreListView()
                .tabItem {
                    Label("My books", systemImage: "books.vertical.fill")
                }
                .tag(TabItem.purchased)
            
            BookstoreListView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                .tag(TabItem.search)
            
//            AccountDetailView()
//                .tabItem {
//                    Label("Account", systemImage: "person.crop.circle.fill")
//                }
//                .tag(TabItem.account)
            
            SettingsListView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tag(TabItem.setting)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

