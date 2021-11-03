//
//  SignUpView.swift
//  MadRentals
//
//  Created by Galen Quinn on 10/3/21.
//

import SwiftUI
import Combine

struct SignUpView : View {
    
    @ObservedObject private var viewModel = ViewModelModule.passSignUpViewModel()
    
    var titleSection : some View {
        ZStack {
            
            
                
                    
                Text("Sign Up")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    
                
            
        }
    }
    
    var signUpFields : some View {
        VStack {
            CustomTextField(image: "person", placeHolder: "Username or Email Address", txt: $viewModel.email, color : Color.black)
                .foregroundColor(.black)
            CustomTextField(image: "lock", placeHolder: "Password", txt: $viewModel.password, color : Color.black)
                .foregroundColor(.black)
            CustomTextField(image: "lock", placeHolder: "Re-Enter Password", txt: $viewModel.password, color : Color.black)
                .foregroundColor(.black)
                
        }
        .padding(.horizontal, 15)
    }
    
    var signUpButton : some View {
        Button(action: {
            
                viewModel.onSignUpTap()
            
        }) {
            Text("SIGN UP")
                .fontWeight(.bold)
                .foregroundColor(Color.white)
                .padding(.vertical)
                .frame(width: (UIScreen.main.bounds.width/2) - 15)
                .background(Color.blue.clipShape(Capsule()).shadow(radius: 2))
        }
        .padding(.vertical)

    }
    
    var body: some View {
        
        NavigationView {
                
                VStack {
                    
                    titleSection
                    
                    Spacer()
                    
                    Spacer()
                    
                    signUpFields
                    
                    signUpButton
                        
                    Spacer()
                    
                }
                .background(Color.white.ignoresSafeArea())
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
}




