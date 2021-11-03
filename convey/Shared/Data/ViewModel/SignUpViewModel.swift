//
//  SignUpViewModel.swift
//  MadRentals
//
//  Created by Galen Quinn on 10/3/21.
//

//import Foundation

import SwiftUI

class SignUpViewModel : ObservableObject {
    
    @Published var signUpData = AuthData()
    
    var email : String {
        get {
            signUpData.username ?? ""
        }
        set (value) {
            signUpData.username = value
        }
    }
    
    var password : String {
        get {
            signUpData.password ?? ""
        }
        set (value) {
            signUpData.password = value
        }
    }
    
    private var authService : AuthService
    
    init(authService : AuthService) {
        self.authService = authService
    }
    

    func onSignUpTap() {
        
        authService.signUp(email: email, password: password)
        
        signUpData.username = nil
        signUpData.password = nil
        
    }

    
}
