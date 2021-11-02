//
//  LandingView.swift
//  Shared
//
//  Created by Galen Quinn on 11/1/21.
//

import SwiftUI

struct LandingView: View {
    
    @ObservedObject private var viewModel = ViewModelModule.passLandingViewModel()
    
    var body: some View {
        
        ZStack {
            
            // if the user is signed in, it will go to the tenant/owner flow
            if viewModel.isSignedIn {
 
                    RecordView()
                           
            } else {
                
                SignInView()
                
            }
        }.background(Color.red.opacity(0.7).ignoresSafeArea())
        
    }
}

