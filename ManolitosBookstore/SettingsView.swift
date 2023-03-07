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
                            Label("User", systemImage: "person.crop.circle")
                            Spacer()
                            Button {
                                appVM.screen = .login
                            } label: {
                                Text("Login")
                                    .foregroundColor(.accentColor)
                            }
                        }
                    }
                } header: {
                    Text("Account")
                }
                Section {
                    Picker("Dark/Light mode", selection: $preferredColorScheme) {
                        Text("Automatic").tag(0)
                        Text("Light").tag(1)
                        Text("Dark").tag(2)
                    }
                } header: {
                    Text("Appearance")
                }
            }
            .navigationTitle("Settings")
            .navigationDestination(for: BooksOrder.self) { po in
                OrderDetailView(vm: OrderDetailVM(order: po))
            }
            .navigationDestination(for: BooksOrder.self) { po in
                OrderDetailView(vm: OrderDetailVM(order: po))
            }
            .navigationDestination(for: Book.self) { book in
                BookDetailView(vm: RowVM(book: book))
            }
        }
    }
}

struct SettingsListView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsListView()
            .environmentObject(BooksViewModel(.inPreview))
    }
}
