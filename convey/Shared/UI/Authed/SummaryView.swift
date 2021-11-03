//
//  SummaryView.swift
//  convey (iOS)
//
//  Created by Galen Quinn on 11/2/21.
//

import SwiftUI

struct SummaryView : View {
    
    @ObservedObject private var viewModel = ViewModelModule.passSummaryViewModel()
    
    var body: some View {
        
        ZStack {
            
            Button(action: {
                viewModel.signOut()
            }, label: {
                Text("Sign Out")
                
            })
            
        }
        .background(Color.white.ignoresSafeArea())
        
    }
}
