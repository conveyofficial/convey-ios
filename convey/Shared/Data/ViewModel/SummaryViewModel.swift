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
        
        
        firestoreService.userRecordsPublisher
            .sink { records in
                
                if records != nil {
                    self.recordList = records!
                }
                        
                
            }.store(in: &cancellables)
    }
    
    func signOut() {
        
        authService.signOut()
        
    }
    
    func getFillerWordCount(topFreqFillerDict : [String : Int]) -> Int {
        
        
        var totalFillers = 0
        
        
        for fillerCount in topFreqFillerDict.values {
            totalFillers += fillerCount
        }
        
        return totalFillers
        
    }
    
}
