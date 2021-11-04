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
        
        VStack {
            
            Text("Recordings:")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            
        }
    }
    
    var recordList : some View {
        
        ScrollView {
            VStack {
                ForEach(viewModel.recordList, id: \.RecordId) { rec in
                    Text("Record: " + rec.RecordName!)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .padding(.vertical)
            }
            .listStyle(PlainListStyle())
        }
        }
    }
    
    var body: some View {
        
        VStack {
            
            titleSection
            
            Spacer()
            
            recordList
            
            Spacer()
            
        }
        .background(Color.red.opacity(0.7).ignoresSafeArea())
    }
}

