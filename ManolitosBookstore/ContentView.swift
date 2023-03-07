//
//  ContentView.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 2/2/23.
//

import SwiftUI

enum TabItem {
  case discover, purchased, search, orders, setting

}

struct ContentView: View {
    @EnvironmentObject var appVM:BooksViewModel
    
    @State private var selection: TabItem = .purchased
    
    var body: some View {

        TabView(selection: $selection) {
            
            DiscoverView()
                .tabItem {
                    Label("Discover", systemImage: "star.fill")
                }
                .tag(TabItem.discover)
            
            MyBooksListView()
                .tabItem {
                    Label("My books", systemImage: "books.vertical.fill")
                }
                .tag(TabItem.purchased)
            
            BookstoreListView()
                .tabItem {
                    Label("Bookstore", systemImage: "bag.fill")
                }
                .tag(TabItem.search)
            
            BookstoreOrderListView()
                .tabItem {
                    Label("Orders", systemImage: "purchased")
                }
                .tag(TabItem.orders)

            SettingsListView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tag(TabItem.setting)

        }
//        .onAppear() {
//            //UIToolbar.appearance().backgroundColor = .systemYellow
//            UITabBar.appearance().backgroundColor = .systemYellow 
//        }
//        .background(Color.red)
////        Color(.red)
//        Color(red: 253.0/255.0, green: 221.0/255.0, blue: 106.0/255.0)
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

