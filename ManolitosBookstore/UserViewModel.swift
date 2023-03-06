//
//  UserViewModel.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 7/2/23.
//

import Foundation

final class UserViewModel: ObservableObject {
    private let persistence = ModelPersistence()
    
    let user:Client?
    
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

    func returnSavedUSer() -> Client {
        return Client(name: name, email: email, location: location, role: role)
    }

    func fieldNotEmpty(value:String) -> String? {
        if value.isEmpty {
            return "%@ cannot be empty."
        } else {
            return nil
        }
    }
    
    func validateEmail(value:String) -> String? {
        guard !value.isEmpty else { return "%@ cannot be empty." }
        do {
            let regex = try Regex(#"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])"#)
            let email = try regex.wholeMatch(in: value)
            if email == nil {
                return "This is not a valid email."
            } else {
                return nil
            }
        } catch {
            return "This is not a valid email."
        }
    }
    
    func createUser() {
        let new = Client(name: self.name, email: self.email, location: self.location, role: Role.client)
        //TODO: - Create function
        //Task { await createUserAsync(new: new) }
    }
    
    func updateUser() {
        returnSavedUSer()
        //Task { await updateUserAsync(update: update) }
    }
    
    
    var mustDisableSaveButton:Bool {
        return (name == user!.name &&
            email == user!.email &&
            location == user!.location &&
            role == user!.role)
    }
}
