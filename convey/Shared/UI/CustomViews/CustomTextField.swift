//
//  CustomTextField.swift
//  MadRentals
//

import UIKit
import SwiftUI
import Combine

struct CustomTextField : View {
    
    var image : String
    var placeHolder : String
    @Binding var txt : String
    var color : Color

    var passwordText : some View {
        
        ZStack(alignment : Alignment(horizontal: .leading, vertical: .center)) {
            Image(systemName : image)
                .font(.system(size : 24))
                .foregroundColor(Color(.black))
                .frame(width : 60, height : 60)
                .background(color)
                .clipShape(Circle())
            
            ZStack {
                SecureField("", text : $txt)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .placeholder(when: txt.isEmpty) {
                        Text(placeHolder).foregroundColor(.black.opacity(0.4))
                    }
            }
            .padding(.horizontal)
            .padding(.leading,65)
            .frame(height: 60)
            .background(color.opacity(0.2))
            .clipShape(Capsule())
        }
    }
    
    var emailAddress : some View {
        ZStack(alignment : Alignment(horizontal: .leading, vertical: .center)) {
            Image(systemName : image)
                .font(.system(size : 24))
                .foregroundColor(Color(.black))
                .frame(width : 60, height : 60)
                .background(color)
                .clipShape(Circle())
            
            ZStack {
                TextField("", text : $txt)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .placeholder(when: txt.isEmpty) {
                        Text(placeHolder).foregroundColor(.black.opacity(0.4))
                    }
            }
            .padding(.horizontal)
            .padding(.leading,65)
            .frame(height: 60)
            .background(color.opacity(0.2))
            .clipShape(Capsule())
        }
    }
    
    var defaultView : some View {
        ZStack(alignment : Alignment(horizontal: .leading, vertical: .center)) {
            Image(systemName : image)
                .font(.system(size : 24))
                .foregroundColor(Color(.black))
                .frame(width : 60, height : 60)
                .background(color)
                .clipShape(Circle())
            
            ZStack {
                TextField("", text : $txt)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .placeholder(when: txt.isEmpty) {
                        Text(placeHolder).foregroundColor(.black.opacity(0.4))
                    }
            }
            .padding(.horizontal)
            .padding(.leading,65)
            .frame(height: 60)
            .background(color.opacity(0.2))
            .clipShape(Capsule())
        }
    }
    
    var body : some View {
        
        ZStack(alignment : Alignment(horizontal: .leading, vertical: .center)) {
            
            
            switch placeHolder {
            case "Password", "Re-Enter":
                passwordText
                
            case "Username or Email Address":
                emailAddress
                
            default:
                defaultView
            }
            
            
            
            
        }
        .padding(.horizontal)
    }
    
    func numericValidator(newValue: String) {
        if newValue.range(of: "^\\d+$", options: .regularExpression) != nil {
            self.txt = newValue
        } else if !self.txt.isEmpty {
            self.txt = String(newValue.prefix(self.txt.count - 1))
        }
    }
}
