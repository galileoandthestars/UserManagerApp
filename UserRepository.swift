//
//  UserRepository.swift
//  UserManagerApp
//
//  Created by Fabiola Fonseca Rivera on 12/9/24.
//

import Foundation

class UserRepository {
    // Save user to database
    func save(user: User) {
        Database.saveUser(user: user)
    }
    func getUserByEmail(email: String) -> User? {
        Database.getUserByEmail(email: email)
    }
}

