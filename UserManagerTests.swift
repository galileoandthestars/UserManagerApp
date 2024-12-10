//
//  UserManagerTests.swift
//  UserManagerApp
//
//  Created by Fabiola Fonseca Rivera on 12/9/24.
//

import XCTest
@testable import UserManagerApp

class UserManagerTests: XCTestCase {
    
    var userManager: UserManager!
    var userValidator: UserValidator!
    var userRepository: UserRepository!
    var emailService: EmailService!
    
    override func setUp() {
        super.setUp()
        userValidator = UserValidator()
        userRepository = UserRepository()
        emailService = EmailService()
        userManager =  UserManager(userValidator: userValidator, userRepository: userRepository)
    }
    
    override func tearDown() {
        userManager = nil
        userValidator = nil
        userRepository = nil
        emailService = nil
        super.tearDown()
    }
    
    func testSuccesfulUserRegistration(){
        let testUser = UserRegistrationDetails(firstName: "Fabiola", lastName: "Fonseca", email: "fabi.fonseca@test.com", password: "test1234", age: 25)
        
        userManager.registerUser(userRegistrationDetails: testUser)
        
        let user = userRepository.getUserByEmail(email: testUser.email)
        
        XCTAssertNotNil(user, "User should be registered successfully")
        XCTAssertEqual(user?.userRegistrationDetails.firstName, "Fabiola", "First name should match")
        XCTAssertEqual(user?.userRegistrationDetails.lastName, "Fonseca", "Last name should match")
        XCTAssertEqual(user?.userRegistrationDetails.email,"fabi.fonseca@test.com" , "Email should match")
        XCTAssertEqual(user?.userRegistrationDetails.age, 25, "Age should match")
    }
    
    func testRegistrationFailureDueToInvalidData() {
          let invalidUserRegistrationDetails = UserRegistrationDetails(
              firstName: "",
              lastName: "",
              email: "invalidemail",
              password: "123",
              age: 16
          )
          
          XCTAssertNil(userManager.registerUser(userRegistrationDetails: invalidUserRegistrationDetails), "User should not be registered with invalid data")
          
          let user = userRepository.getUserByEmail(email: invalidUserRegistrationDetails.email)
        print(user?.userRegistrationDetails.email)
          XCTAssertNil(user, "No user should be saved in the repository with invalid data")
    }
    
    func testAuthenticationWithValidCredentials(){
        let userRegistrationDetails = UserRegistrationDetails(
            firstName: "John",
            lastName: "Doe",
            email: "john.doe@example.com",
            password: "password123",
            age: 25
        )
        
        userManager.registerUser(userRegistrationDetails: userRegistrationDetails)
        
        let isAuthenticated = userManager.authenticateUser(email: userRegistrationDetails.email, password: userRegistrationDetails.password)
        
        XCTAssertTrue(isAuthenticated, "User should be authenticated successfully with correct credentials")
        
    }
    
    func testAuthenticationWithInvalidCredentials(){
        let userRegistrationDetails = UserRegistrationDetails(
            firstName: "John",
            lastName: "Doe",
            email: "john.doe@example.com",
            password: "password123",
            age: 25
        )
        
        userManager.registerUser(userRegistrationDetails: userRegistrationDetails)
        
        let isAuthenticated = userManager.authenticateUser(email: userRegistrationDetails.email, password: "wrongpassword")
        XCTAssertFalse(isAuthenticated, "User should not be authenticated with incorrect password")
        
    }
    
    func testHandlingOfNonExistentUsersDuringAuthentication(){
        let isAuthenticated = userManager.authenticateUser(email: "nonexistent@example.com", password: "password123")
        
        XCTAssertFalse(isAuthenticated, "User should not be authenticated if they do not exist")
        
    }
}


