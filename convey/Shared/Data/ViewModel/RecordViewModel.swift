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
    @Published var saveRecording = 0
    //0: no recording to look at.
    //1: recording to look at.
    //2: delete recording.
    //3: save recording
    
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
