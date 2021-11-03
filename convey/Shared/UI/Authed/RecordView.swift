//
//  RecordView.swift
//  convey (iOS)
//
//  Created by Galen Quinn on 11/2/21.
//

import SwiftUI

struct RecordView : View {
    
    @ObservedObject private var viewModel = ViewModelModule.passRecordViewModel()
    
    var recordButton : some View {
        Button(action: {
            viewModel.isRecording = true
        }) {
            Text("Record")
                .font(.system(size: 25))
        }.foregroundColor(Color.black)
        .padding(30)
        .background(
            Circle()
            .fill(Color.red)
        )
        
    }
    
    var savePopup : some View {
        HStack {
            //Save
            Button(action: {
                viewModel.showPopup = false
            }) {
                Text("Save")
            }.padding(30)
            
            //Delete
            Button(action: {
                viewModel.showPopup = false
            }) {
                Text("Delete")
            }.padding(30)
        }
    }
    
    
    var stopButton : some View {
        Button(action: {
            viewModel.isRecording = false
            viewModel.showPopup = true
        }) {
            Text("Stop")
                .font(.system(size: 25))
        }.foregroundColor(Color.black)
        .padding(30)
        .background(Color.red)
    }
    
    
    var body: some View {
        
        ZStack {
            
            VStack {
                Button(action: {
                    viewModel.signOut()
                }, label: {
                    Text("Sign Out")
                    
                })
                if viewModel.showPopup {
                    savePopup
                }
                else {
                    if viewModel.isRecording {
                        stopButton
                    } else {
                        recordButton
                    }
                }
                
                
                // This view just needs a convey
            
            }
            
            
        }
        .background(Color.white.ignoresSafeArea())
        
    }
}
