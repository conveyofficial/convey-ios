//
//  RecordView.swift
//  convey (iOS)
//
//  Created by Galen Quinn on 11/2/21.
//

import SwiftUI

struct RecordView : View {
    
    @ObservedObject private var viewModel = ViewModelModule.passRecordViewModel()
    
    @State var hours: Int = 0
    @State var minutes: Int = 0
    @State var seconds: Int = 0
    
    @State var timer: Timer? = nil
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { tempTimer in
            if self.seconds == 59 {
                self.seconds = 0
                if self.minutes == 59 {
                    self.minutes = 0
                    self.hours = self.hours + 1
                }
                else {
                    self.minutes = self.minutes + 1
                }
            }
            else {
                self.seconds = self.seconds + 1
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    
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
            self.startTimer()
            viewModel.recordName=""
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
        VStack {
            Text("\(minutes):\(seconds)").foregroundColor(.black)
            
            Button(action: {
                self.stopTimer()
                viewModel.onStopRecordingTap()
                viewModel.time = (Double(seconds) + (60.0 * Double(minutes)))
            }) {
                Text("Stop")
                    .lineLimit(1)
                    .font(.title)
                    .foregroundColor(Color.black)
                    .padding()
            }
            .background(Color.red.clipShape(Capsule()).shadow(radius: 2))
        }
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
