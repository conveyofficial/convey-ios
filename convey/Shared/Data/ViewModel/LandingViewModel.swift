//
//  LandingViewModel.swift
//  MadRentals
//
//  Created by Galen Quinn on 10/3/21.
//

import SwiftUI
import Firebase
import Combine

class LandingViewModel : ObservableObject {
    
    @Published var isSignedIn = false
    @Published var selectedTab = "house"
    
    
    private var authService : AuthService
    private var firestoreService : FirestoreService
    
    private var authListener : AuthStateDidChangeListenerHandle? = nil
    
    private var cancellables = Set<AnyCancellable>()
    
    init(authService : AuthService, firestoreService : FirestoreService) {
        self.authService = authService
        self.firestoreService = firestoreService
        
        setupListeners()
    }
    
    func setupListeners() {
        
        authService.signedInChangePublisher
            .sink(receiveValue: { status in
                
                self.isSignedIn = status
                
                print(status)         
                                
            }).store(in: &cancellables)
   
    }  
}
