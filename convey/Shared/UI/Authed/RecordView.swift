//
//  RecordView.swift
//  convey (iOS)
//
//  Created by Galen Quinn on 11/2/21.
//

import SwiftUI

struct RecordView : View {
    
    @ObservedObject private var viewModel = ViewModelModule.passRecordViewModel()
    
    
    var titleSection : some View {
        Text("Welcome to Convey")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundColor(.black)
    }
    
    var recordButton : some View {
        Button(action: {
            viewModel.onStartRecordingTap()
        }) {
            Text("Record")
                .lineLimit(1)
                .font(.title)
                .foregroundColor(Color.black)
                .padding(30)
        }
        .background(Color.green.clipShape(Circle()))
        
    }
    
    var actionPopup : some View {
        HStack {
            
            Spacer()
            //Save
            
            Button(action: {
                //                viewModel.showPopup = false
                viewModel.saveRecord()
            }) {
                Text("Save")
                    .lineLimit(1)
                    .font(.title)
                    .foregroundColor(Color.black)
                    .padding(30)
            }
            .background(Color.green.clipShape(Circle()))
            
            //            .padding(30)
            
            Spacer()
            
            //Delete
            Button(action: {
                //                viewModel.showPopup = false
                viewModel.deleteRecord()
            }) {
                Text("Delete")
                    .lineLimit(1)
                    .font(.title)
                    .foregroundColor(Color.black)
                    .padding(30)
                
            }
            .background(Color.red)
            
            
            
            Spacer()
        }
    }
    
    
    var stopButton : some View {
        Button(action: {
            viewModel.onStopRecordingtap()
        }) {
            Text("Stop")
                .lineLimit(1)
                .font(.title)
                .foregroundColor(Color.black)
                .padding(30)
        }
        .background(Color.red)
    }
    
    
    var signOutDebug : some View {
        Button(action: {
            viewModel.signOut()
        }, label: {
            Text("Sign Out")
            
        })
    }
    
    
    
    
    var body: some View {
        
        
            
            
            
            
            VStack {
                
                signOutDebug
                
                Spacer()
                
                titleSection
                
                Spacer()
                
                
                if viewModel.promptAction {
                    
                    actionPopup
                    
                } else {
                    
                    
                    if viewModel.isRecording {
                        
                        stopButton
                        
                    } else {
                        
                        recordButton
                        
                    }
                    
                    
                }
                
                Spacer()
                
                Spacer()
                
                
                // This view just needs a convey
                
            }
            
    
        
    }
}
