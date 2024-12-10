//
//  UserManager.swift
//  UserManagerApp
//
//  Created by Fabiola Fonseca Rivera on 12/9/24.
//

// UserManager.swift

import Foundation

class UserManager {
    private var userValidator: UserValidator
    private var userRepository: UserRepository
   
    
    init(userValidator: UserValidator, userRepository: UserRepository) {
        self.userValidator = userValidator
        self.userRepository = userRepository
    }
    
    func registerUser(userRegistrationDetails: UserRegistrationDetails) {
        // validate user
        let user = userValidator.validateRegistration(userRegistrationDetails: userRegistrationDetails)
        
        //save user
        userRepository.save(user: user)
        
        // Send welcome email
        EmailService.sendWelcomeEmail(email: userRegistrationDetails.email)
    }

    func authenticateUser(email: String, password: String) -> Bool {
        return userValidator.validatePassword(email:email, password: password)
    }
}

