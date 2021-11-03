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
    
    init(firestoreService : FirestoreService) {
        self.firestoreService = firestoreService
    }
    
    func onStartRecordingTap() {
        
    }
    
    
    func onFinishRecordingtap() {
        
    }
    
}
