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
            
            
            
            
            if viewModel.isSignedIn {
                
                
                ZStack(alignment: .bottom, content: {
                    
                    
                    
                    
                    Color.blue.opacity(0.3)
                        .ignoresSafeArea()
                    
                    if viewModel.selectedTab == "house" {
                        RecordView()
                    } else {
                        SummaryView()
                    }
                    
                    
                    
                    
                    
                    
                    
                    CustomTabBar(selectedTab: $viewModel.selectedTab)
                })
                
                
                
                
                
            } else {
                
                SignInView()
                
            }
            
            if viewModel.isLoading { LoadingAnimation() }
        }
        .alert(isPresented: $viewModel.alertShowing) {
            Alert(title:
                    Text("Uh oh..."),
                  message: Text(viewModel.alertMessage),
                  dismissButton: .default(Text("OK")))
        }
        .background(Color.white.ignoresSafeArea())
        
    }
}

