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
            
            VStack {
                HStack (spacing: 0) {
                    
                    Text("Sign Up")
                        .font(.system(size: 45))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                }
            }
        }
    }
    
    var signUpFields : some View {
        VStack {
            CustomTextField(image: "person", placeHolder: "Username or Email Address", txt: $viewModel.email, color : Color.white)
                .foregroundColor(.black)
            CustomTextField(image: "lock", placeHolder: "Password", txt: $viewModel.password, color : Color.white)
                .foregroundColor(.black)
                
        }
        .padding(.horizontal, 15)
    }
    
    var signUpTenantButton : some View {
        Button(action: {
            
                viewModel.onSignUpTenantTap()
            
        }) {
            Text("SIGN UP AS TENANT")
                .fontWeight(.bold)
                .foregroundColor(Color.black)
                .padding(.vertical)
                .frame(width: (UIScreen.main.bounds.width/2) - 15)
                .background(Color.red.clipShape(Capsule()).shadow(radius: 2))
        }
        .padding(.vertical)

    }
    
    var signUpOwnerButton : some View {
        Button(action: {
            
                viewModel.onSignUpOwnerTap()
            
        }) {
            Text("SIGN UP AS OWNER")
                .fontWeight(.bold)
                .foregroundColor(Color.black)
                .padding(.vertical)
                .frame(width: (UIScreen.main.bounds.width/2) - 15)
                .background(Color.red.clipShape(Capsule()).shadow(radius: 2))
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
                    
                    signUpOwnerButton
                    signUpTenantButton
                        
                    Spacer()
                    
                }
                .background(LinearGradient(gradient: Gradient(colors : [.black, .red]), startPoint: .leading, endPoint: .trailing).ignoresSafeArea())
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
}




