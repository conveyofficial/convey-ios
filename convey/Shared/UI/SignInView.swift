//
//  SignInView.swift
//  MadRentals
//
//  Created by Galen Quinn on 10/3/21.
//

import SwiftUI
import Combine

struct SignInView : View {
    
    @ObservedObject private var viewModel = ViewModelModule.passSignInViewModel()
    
    var titleSection : some View {
        ZStack {
            
            VStack {
                
                Text("Convey")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                
                Text("Your personal speech assistant.")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
            
            }
        }
    }
    
    var signInFields : some View {
        VStack {
            CustomTextField(image: "person", placeHolder: "Username or Email Address", txt: $viewModel.email, color : Color.gray)
                .foregroundColor(.black)
            CustomTextField(image: "lock", placeHolder: "Password", txt: $viewModel.password, color : Color.gray)
                .foregroundColor(.black)
                
        }
        .padding(.horizontal, 15)
    }
    
    var signUpButton : some View {
        NavigationLink(
            destination: SignUpView(),
            label: {
                Text("Need to sign up?")
                    .foregroundColor(.black)
                    .font(.subheadline)
                    .underline()
            })
            .padding(.bottom, 10)
    }
    
    var signInButton : some View {
        Button(action: {
            
                viewModel.onSignInTap()
            
        }) {
            Text("SIGN IN")
                .fontWeight(.bold)
                .foregroundColor(Color.white)
                .padding(.vertical)
                .frame(width: (UIScreen.main.bounds.width/2) - 15)
                .background(Color.blue.clipShape(Capsule()).shadow(radius: 2))
        }
        .padding(.vertical, 30)

    }
    
    var body: some View {
        
        NavigationView {
                
                VStack {
                    
                    titleSection
                    
                    Spacer()
                    
                    Spacer()
                    
                    signInFields
    
                    signInButton
                    
                    signUpButton
                        
                    Spacer()
                    
                }
                .background(Color.white.ignoresSafeArea())
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
}



