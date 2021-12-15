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
    private var alertService : AlertService
    
    init(authService : AuthService, alertService : AlertService) {
        self.authService = authService
        self.alertService = alertService
    }
    

    func onSignInTap() {
        
        alertService.loadingPublisher.send(true)
        
        authService.signIn(username: email, password: password) { [self] (success, error) in
            
            if success {
                
                signInData.username = nil
                signInData.password = nil
                
                alertService.loadingPublisher.send(false)
                
            } else {
                
                
                alertService.loadingPublisher.send(false)
                
                alertService.alertLoadingPublisher.send(true)
                alertService.alertMessagePublisher.send(error)
                
            }
            
        }
        
       
        
    }
    
}
