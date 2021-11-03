//
//  SummaryViewModel.swift
//  convey (iOS)
//
//  Created by Galen Quinn on 11/2/21.
//

import SwiftUI

class SummaryViewModel : ObservableObject {   
    
    private var firestoreService : FirestoreService
    
    init(firestoreService : FirestoreService) {
        self.firestoreService = firestoreService
    }
    
}
