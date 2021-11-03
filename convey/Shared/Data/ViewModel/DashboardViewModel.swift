//
//  DashboardViewModel.swift
//  convey (iOS)
//
//  Created by Galen Quinn on 11/3/21.
//

import SwiftUI

class DashboardViewModel : ObservableObject {
    
    // data object we temporarily manipulate when on the sign in page
//    @Published var signInData = AuthData()
    
    
    private var firestoreService : FirestoreService
    
    init(firestoreService : FirestoreService) {
        self.firestoreService = firestoreService
    }
    
}
