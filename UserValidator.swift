//
//  UserValidator.swift
//  UserManagerApp
//
//  Created by Fabiola Fonseca Rivera on 12/9/24.
//

import Foundation

class UserValidator {
    
    func validateRegistration(userRegistrationDetails: UserRegistrationDetails) -> User{
        
        // check empty fields
        if  userRegistrationDetails.firstName.isEmpty || userRegistrationDetails.lastName.isEmpty || userRegistrationDetails.email.isEmpty || userRegistrationDetails.password.isEmpty {
            fatalError("All fields must be filled")
        }
        //check email format
        if !userRegistrationDetails.email.contains("@") {
            fatalError("Invalid email address")
        }
        //check password length
        if userRegistrationDetails.password.count < 6 {
            fatalError("Password must be at least 6 characters")
        }
        //check age
        if userRegistrationDetails.age < 18 {
            fatalError("User must be at least 18 years old")
        }
        let user = User(userRegistrationDetails: userRegistrationDetails)
        return user
    }
    
    func validatePassword(email: String, password: String) -> Bool{
        let user = Database.getUserByEmail(email: email)
        //check if user is nil
        if user == nil {
            return false
        }
        return user?.userRegistrationDetails.password == password
    }
    
}
