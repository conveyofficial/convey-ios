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
                
                
                ZStack {
                    
                    if viewModel.selectedTab == "record" {
                        RecordView()
                    } else {
                        SummaryView()
                    }
                    
                   
                    
//                    CustomTabBar(selectedTab: $viewModel.selectedTab)
                    
                }
 
                    
                           
            } else {
                
                SignInView()
                
            }
        }.background(Color.white.ignoresSafeArea())
        
    }
}

