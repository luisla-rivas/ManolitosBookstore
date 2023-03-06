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
        //let _ = Self._printChanges()
        NavigationStack {
            List {
                Section {
                    if appVM.currentUser != nil {                    NavigationLink(destination: AccountDetailView()) {
                            HStack {
                                Label("Account", systemImage: "person.crop.circle")
                                Spacer()
                                Text(appVM.currentUser?.name ?? "-").foregroundColor(Color(uiColor: .secondaryLabel))
                            }
                        }
                    } else {
                        HStack {
                            Label("Account", systemImage: "person.crop.circle")
                            Spacer()
                            Button {
                                appVM.screen = .login
                            } label: {
                                Text("Login")
                                    .foregroundColor(.accentColor)
                            }
                        }
                    }
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
            .environmentObject(BooksViewModel(.inPreview))
    }
}
