//
//  SettingsView.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 7/2/23.
//

import SwiftUI

struct SettingsListView: View {
    @AppStorage("preferredColorScheme") var preferredColorScheme: Int = 0
    @EnvironmentObject var appVM: BooksViewModel
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    NavigationLink(destination: AccountDetailView(userVM: UserViewModel(user: appVM.currentUser))) {
                        HStack {
                            Label("Account", systemImage: "person.crop.circle")
                            Spacer()
                            Text("Manolito").foregroundColor(Color(uiColor: .secondaryLabel))
                        }
                    }
                } header: {
                    Text("")
                }
                Section {
                    Picker("Dark/Light mode", selection: $preferredColorScheme) {
                        Text("Automatic").tag(0)
                        Text("Light").tag(1)
                        Text("Dark").tag(2)
                    }
                } header: {
                    Text("")
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
