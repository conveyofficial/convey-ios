//
//  SignUpViewModel.swift
//  MadRentals
//
//  Created by Galen Quinn on 10/3/21.
//

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
    
    var passwordReEntered : String {
        get {
            signUpData.passwordReEntered ?? ""
        }
        set (value) {
            signUpData.passwordReEntered = value
        }
    }
    
    private var authService : AuthService
    private var alertService : AlertService
    
    init(authService : AuthService, alertService : AlertService) {
        self.authService = authService
        self.alertService = alertService
    }
    

    func onSignUpTap() {
        
        alertService.loadingPublisher.send(true)
        
        if password != passwordReEntered {
            
            alertService.loadingPublisher.send(false)
            
            alertService.alertLoadingPublisher.send(true)
            alertService.alertMessagePublisher.send("Cannot sign-up. Passwords do not match.")
            
        } else {
            
            authService.signUp(email: email, password: password) { [self] (success, error) in
                
                if success {
                    
                    signUpData.username = nil
                    signUpData.password = nil
                    signUpData.passwordReEntered = nil
                    
                    alertService.loadingPublisher.send(false)
                    
                } else {
                    
                    alertService.loadingPublisher.send(false)
                    
                    alertService.alertLoadingPublisher.send(true)
                    alertService.alertMessagePublisher.send(error)

                }
                
            }
            
            
            
        }
        
        
        
    }

    
}
