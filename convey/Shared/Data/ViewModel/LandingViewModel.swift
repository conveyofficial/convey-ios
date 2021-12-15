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
    
    @Published var isLoading = false
    @Published var alertShowing = false
    @Published var alertMessage = ""
    
    @Published var isSignedIn = false
    @Published var selectedTab = "house"
    
    
    private var authService : AuthService
    private var firestoreService : FirestoreService
    private var alertService : AlertService
    
    
    private var authListener : AuthStateDidChangeListenerHandle? = nil
    
    private var cancellables = Set<AnyCancellable>()
    
    init(authService : AuthService, firestoreService : FirestoreService, alertService : AlertService) {
        self.authService = authService
        self.firestoreService = firestoreService
        self.alertService = alertService
        
        setupListeners()
    }
    
    func setupListeners() {
        
        authService.signedInChangePublisher
            .sink(receiveValue: { status in
                
                self.isSignedIn = status
                
                print(status)         
                                
            }).store(in: &cancellables)
        
        alertService.loadingPublisher
            .sink(receiveValue: { status in
                
                self.isLoading = status
                
            }).store(in: &cancellables)
        
        alertService.alertLoadingPublisher
            .sink(receiveValue: { status in
                
                self.alertShowing = status
                
            }).store(in: &cancellables)
        
        alertService.alertMessagePublisher
            .sink(receiveValue: { status in
                
                self.alertMessage = status
                
            }).store(in: &cancellables)
        
        
        
        
   
    }  
}
