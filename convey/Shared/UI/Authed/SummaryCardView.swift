//
//  SummaryCardView.swift
//  convey (iOS)
//
//  Created by Galen Quinn on 11/24/21.
//

import SwiftUI
import Combine

struct SummaryCardView: View {
    
    @ObservedObject private var viewModel = ViewModelModule.passSummaryViewModel()
    
    var record : FirestoreRecord
    
    @State private var angle: Double = 0
    @State private var expandMoreDetails = false
    
    @State var expandValueState : Double = 0.0
    
    @State var forceCollapsed = false
    
    var chevronImage : some View {
        ZStack {
            Image(systemName: "chevron.right")
                .font(.title)
                .padding(.trailing)
                .foregroundColor(Color.black)
                .rotationEffect(.degrees(getAngle()))
                .animation(.spring())
            
            
        }
    }
    
    var body: some View {
        
        HStack(alignment: .center, spacing: 15) {
            
            VStack(alignment: .leading,spacing: 0){
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    HStack {
                        
                        VStack(alignment: .leading) {
                            
                            
                            if record.RecordName == "" {
                                Text("No Record Name")
                                        .foregroundColor(.black)
                                        .font(.title2.bold())
                                        .lineLimit(1)
                                
                            } else {
                                Text(record.RecordName ?? "No Record Name")
                                        .foregroundColor(.black)
                                        .font(.title2.bold())
                                        .lineLimit(1)
                            }
                            
                            

                            
                            
                            
                        }
                        
                        
                        Spacer()
                        
                        chevronImage
                        
                        
                    }
                    
                }
                .frame(height: 100)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                
                if expandValueState != 0 {
                    
                    
                
                
                    withAnimation {
                    
                    VStack(alignment: .leading, spacing: 10) {
                        
                        HStack {
                            
                            Text("Record Details")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                            
                            Rectangle()
                                .fill(Color.black.opacity(0.6))
                                .frame(height: 0.5)
                            
                        }
                        .padding(.vertical, 8)
                        .transition(.move(edge: .top))
                        
                        Text("Time: " + String(record.Time ?? 0.0) + " seconds")
                            .foregroundColor(.black)
                            .fontWeight(.semibold)
                            .font(.subheadline)
                        
                        Text("Word Count: " + String(record.WordCount ?? 0) + " total words")
                            .foregroundColor(.black)
                            .fontWeight(.semibold)
                            .font(.subheadline)
                        
                        Text("Pace: " + String(record.Wpm ?? 0) + " wpm")
                            .foregroundColor(.black)
                            .fontWeight(.semibold)
                            .font(.subheadline)
                        
                        Text("Filler Word Count: \(viewModel.getFillerWordCount(topFreqFillerDict: record.topFreqFillers ?? [:])) fillers")
                            .foregroundColor(.black)
                            .fontWeight(.semibold)
                            .font(.subheadline)
                        
                        Spacer()
    

                    }
                        
                    }
                    
                }
            }
            
            Spacer(minLength: 0)
        }
        .padding(.horizontal, 15)
        .frame(height: 100 + abs(CGFloat(getMaxCardSize())))
        .background(Color.blue.clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))))
        .clipped()
        .shadow(color: .black.opacity(0.5), radius: 3)
        .padding()
        .onTapGesture {
            
            (expandValueState == 0) ? withAnimation { expandValueState = 4.5 } : withAnimation { expandValueState = 0}

        }
        
    }
    
    func getMaxCardSize() -> CGFloat {
        
        if expandValueState == 0 {
            
            return CGFloat(0)
            
        } else {
            
            return .infinity
        }
    }
 

    func getAngle() -> Double {
        
        if expandValueState == 0 {
            
            return 0
            
        } else {
            
            return 90
            

        }
        
    }
    
    
}


