//
//  RecordView.swift
//  convey (iOS)
//
//  Created by Galen Quinn on 11/2/21.
//

import SwiftUI

struct RecordView : View {
    
    @ObservedObject private var viewModel = ViewModelModule.passRecordViewModel()
    
    var body: some View {
        
        ZStack {
            
            Button(action: {
                viewModel.signOut()
            }, label: {
                Text("Sign Out")
                
            })
            
            
            // This view just needs a convey
            
            
        }
        .background(Color.white.ignoresSafeArea())
        
    }
}
