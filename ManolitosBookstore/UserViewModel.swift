//
//  UserViewModel.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 7/2/23.
//

import Foundation

final class UserViewModel: ObservableObject {
    private let persistence = ModelPersistence()
    
    private let user:Client?
    
//    @Published var  firstName = ""
//    @Published var  lastName = ""
    @Published var  name = ""
    @Published var  email = ""
    @Published var  location = ""
    @Published var  role = Role.client

    
    init(user:Client?) {
        self.user = user
        if let user = user {
            name = user.name
            email = user.email
            location = user.location
            role = user.role
        }
    }

    func saveInfo() -> Client {
        return Client(name: name, email: email, location: location, role: role)
    }

//    var mustDisableSaveButton:Bool {
//        return (name == user.name &&
//            email == user.email &&
//            location == user.location &&
//            role == user.role)
//    }
}
