//
//  SummaryView.swift
//  convey (iOS)
//
//  Created by Galen Quinn on 11/2/21.
//

import SwiftUI


struct SummaryCardView : View {
    var rec : FirestoreRecord
    
    var body : some View {
        VStack {
            Text("Record: " + rec.RecordName!)
                .font(.title3)
                .fontWeight(.bold)
                .padding(.top)
                .foregroundColor(.blue)
            
            Text("Time: " + "\(String(describing:rec.Time!)) seconds")
                .font(.headline)
                .fontWeight(.bold)
                .padding(.top)
                .foregroundColor(.blue)
            
            Text("Debug Text: " + rec.ParsedText!)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.black)
                .padding(.horizontal)

        }
    }
}

struct SummaryView : View {
    
    @ObservedObject private var viewModel = ViewModelModule.passSummaryViewModel()
    
    var titleSection : some View {
        
        VStack {
            
            Text("Recordings")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.black)
            
        }
    }

    
    
    
    var recordList : some View {
        
        ScrollView {
            VStack {
                ForEach(viewModel.recordList, id: \.RecordId) { rec in
                    SummaryCardView(rec: rec)
                                }
            .listStyle(PlainListStyle())
        }
        }
    }
    
    var body: some View {
        
        VStack {
            
            Spacer()
            
            titleSection
            
            Spacer()
            
            recordList
            
            Spacer()
            
        }
//        .frame(width: UIScreen.main.bounds.width)
//        .background(Color.red.opacity(0.7).ignoresSafeArea())
    }
}

