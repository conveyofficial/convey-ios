//
//  SummaryView.swift
//  convey (iOS)
//
//  Created by Galen Quinn on 11/2/21.
//

import SwiftUI

struct SummaryView : View {
    
    @ObservedObject private var viewModel = ViewModelModule.passSummaryViewModel()
    
    var titleSection : some View {
        
        Text("Recordings")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundColor(.black)
            .padding()
        
        
    }
    
    
    
    
    var recordList : some View {
        
        ScrollView() {
            
            VStack(spacing: 5) {
                
                if viewModel.recordList.isEmpty {
                    
                    Text("No Records")
                        .font(.title)
                        .foregroundColor(.gray)
                    
                } else {
                    
                    
                    ForEach(viewModel.recordList, id: \.RecordId) { rec in
                        
                        SummaryCardView(record: rec)
                        
                        
                        
                    }
                    
                    
                }
                
            }
            .listStyle(PlainListStyle())
        }
        .frame(height: UIScreen.main.bounds.height - 250)
    }
    
    var body: some View {
        
        VStack {
            
            
            titleSection
            
            recordList
            
            
            Spacer()
            Spacer()
            
        }
    }
}

