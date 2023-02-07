//
//  SettingsView.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 7/2/23.
//

import SwiftUI

struct SettingsListView: View {
    @AppStorage("preferredColorScheme") var preferredColorScheme: Int = 0
    
    var body: some View {
        NavigationView {
            List {
                Picker("Dark/Light mode", selection: $preferredColorScheme) {
                    Text("Automatic").tag(0)
                    Text("Light").tag(1)
                    Text("Dark").tag(2)
                }
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsListView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsListView()
    }
}
