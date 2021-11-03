//
//  SummaryViewModel.swift
//  convey (iOS)
//
//  Created by Galen Quinn on 11/2/21.
//

import SwiftUI

class SummaryViewModel : ObservableObject {   
    
    private var firestoreService : FirestoreService
    private var authService : AuthService
    
    init(firestoreService : FirestoreService, authService : AuthService) {
        self.firestoreService = firestoreService
        self.authService = authService
        
        setupListeners()
    }
    
    func setupListeners() {
        
    }
    
    func signOut() {
        authService.signOut()
    }
    
}
