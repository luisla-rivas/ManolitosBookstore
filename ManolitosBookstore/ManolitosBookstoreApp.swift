//
//  ManolitosBookstoreApp.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 2/2/23.
//

import SwiftUI

@main
struct ManolitosBookstoreApp: App {
    @AppStorage("preferredColorScheme") var preferredColorScheme: Int = 0
    
    @StateObject var appVM = BooksViewModel(.inPreview)
    
    var body: some Scene {
        WindowGroup {
            VStack {
                if UIDevice.current.userInterfaceIdiom == .pad {
                    ContentView() // ContentPadView()
                } else {
                    StateLoginView()
                }
            }
            .environmentObject(appVM)
//            .task {
//                let (_,_) = await (appVM.getAllBooks(), appVM.getAuthors())
//            }
            .preferredColorScheme(ColorScheme.init(
                .init(rawValue: preferredColorScheme) ?? .light))
            
        }
        
    }
}
