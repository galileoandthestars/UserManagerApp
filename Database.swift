//
//  Database.swift
//  UserManagerApp
//
//  Created by Fabiola Fonseca Rivera on 12/9/24.
//

// Database.swift

import Foundation

class Database {
    private static var users: [User] = []

    static func saveUser(user: User) {
        users.append(user)
    }

    static func getUserByEmail(email: String) -> User? {
        return users.first { $0.userRegistrationDetails.email == email }
    }
}

