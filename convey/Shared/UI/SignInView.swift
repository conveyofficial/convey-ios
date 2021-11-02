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
                HStack (spacing: 0) {
                    Text("Mad")
                        .font(.system(size: 45))
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                    Text("Rentals")
                        .font(.system(size: 45))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                }
                
                Text("Spike Exercise")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            
            }
        }
    }
    
    var signInFields : some View {
        VStack {
            CustomTextField(image: "person", placeHolder: "Username or Email Address", txt: $viewModel.email, color : Color.white)
                .foregroundColor(.black)
            CustomTextField(image: "lock", placeHolder: "Password", txt: $viewModel.password, color : Color.white)
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
                .foregroundColor(Color.black)
                .padding(.vertical)
                .frame(width: (UIScreen.main.bounds.width/2) - 15)
                .background(Color.red.clipShape(Capsule()).shadow(radius: 2))
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
                .background(LinearGradient(gradient: Gradient(colors : [.black, .red]), startPoint: .leading, endPoint: .trailing).ignoresSafeArea())
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
}



