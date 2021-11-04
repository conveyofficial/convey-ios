//
//  SummaryViewModel.swift
//  convey (iOS)
//
//  Created by Galen Quinn on 11/2/21.
//

import SwiftUI
import Combine

class SummaryViewModel : ObservableObject {
    
    @Published var recordList : [FirestoreRecord] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    private var firestoreService : FirestoreService
    private var authService : AuthService
    
    init(firestoreService : FirestoreService, authService : AuthService) {
        self.firestoreService = firestoreService
        self.authService = authService
        
        setupListeners()
    }
    
    func setupListeners() {
        firestoreService.userPublisher
            .sink { user in
                
                if user != nil {

                    if !user!.Records!.isEmpty {
                        
                        self.recordList = user!.Records!
                        
                    }
                    
                }
                
            }.store(in: &cancellables)
    }
    
    func signOut() {
        authService.signOut()
    }
    
}
