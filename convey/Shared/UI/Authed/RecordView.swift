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
        
        VStack {
            
            Text("Convey")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding()
            
            Text("Your personal speech assistant")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.blue)
                
            
        }
        
    }
    
    var recordButton : some View {
        Button(action: {
            viewModel.onStartRecordingTap()
        }) {
            Text("Record")
                .lineLimit(1)
                .font(.title)
                .foregroundColor(Color.black)
                .padding()
        }
        .background(Color.blue.clipShape(Capsule()).shadow(radius: 2))
        
    }
    
    
    var actionPopup : some View {
        VStack {
            

            TextField("Enter record name here: ", text: $viewModel.recordName)
//                .multilineTextAlignment(.center)
                .frame(width: UIScreen.main.bounds.size.width - 100)
                .foregroundColor(Color.black)
                .padding(10)
                .background(Color.white.clipShape(RoundedRectangle(cornerRadius: 5)))
                .padding(30)
            
            

            
                
            
            
            HStack {
                
                Spacer()
                
                Button(action: {
                    viewModel.saveRecord()
                }) {
                    Text("Save")
                        .lineLimit(1)
                        .font(.title)
                        .foregroundColor(Color.black)
                        .padding()
                }
                .background(Color.green.clipShape(Capsule()).shadow(radius: 2))
                
                Spacer()
                
                Button(action: {
                
                    viewModel.deleteRecord()
                }) {
                    Text("Delete")
                        .lineLimit(1)
                        .font(.title)
                        .foregroundColor(Color.black)
                        .padding()
                    
                }
                .background(Color.red.clipShape(Capsule()).shadow(radius: 2))
                
                
                
                Spacer()
            }
        }
       
    }
    
    
    var stopButton : some View {
        Button(action: {
            viewModel.onStopRecordingTap()
        }) {
            Text("Stop")
                .lineLimit(1)
                .font(.title)
                .foregroundColor(Color.black)
                .padding()
        }
        .background(Color.red.clipShape(Capsule()).shadow(radius: 2))
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
                
                titleSection
                
                Spacer()
                
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
                
                
            }
            
    
        
    }
}
