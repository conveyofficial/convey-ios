//
//  RecordViewModel.swift
//  convey (iOS)
//
//  Created by Galen Quinn on 11/2/21.
//

import SwiftUI
import Speech

class RecordViewModel : ObservableObject {
    
    private var firestoreService : FirestoreService
    private var authService : AuthService
    
    init(firestoreService : FirestoreService, authService : AuthService) {
        self.firestoreService = firestoreService
        self.authService = authService
    }
    
    func signOut() {
        authService.signOut()
    }
    
    
    func onStartRecordingTap() {
        
    }
    
    
    func onFinishRecordingtap() {
        
    }
    
}
