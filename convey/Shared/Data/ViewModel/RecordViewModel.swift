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
    
    @Published var isRecording = false
    @Published var promptAction = false
    
    init(firestoreService : FirestoreService, authService : AuthService) {
        self.firestoreService = firestoreService
        self.authService = authService
    }
    
    func signOut() {
        authService.signOut()
    }
    
    
    func onStartRecordingTap() {
        
        isRecording = true
        
    }
    
    
    func onStopRecordingtap() {
        
        isRecording = false
        promptAction = true
        
    }
    
    
    func saveRecord() {
        promptAction = false
        
        
    }
    
    func deleteRecord() {
        promptAction = false
        
    }
    
}
