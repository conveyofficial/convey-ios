//
//  SignInViewModel.swift
//  MadRentals
//
//  Created by Galen Quinn on 10/3/21.
//

import SwiftUI

class SignInViewModel : ObservableObject {
    
    // data object we temporarily manipulate when on the sign in page
    @Published var signInData = AuthData()
    
    var email : String {
        get {
            signInData.username ?? ""
        }
        set (value) {
            signInData.username = value
        }
    }
    
    var password : String {
        get {
            signInData.password ?? ""
        }
        set (value) {
            signInData.password = value
        }
    }
    
    private var authService : AuthService
    
    init(authService : AuthService) {
        self.authService = authService
    }
    

    func onSignInTap() {
        
        authService.signIn(username: email, password: password)
        
        signInData.username = nil
        signInData.password = nil
        
    }
    
}
