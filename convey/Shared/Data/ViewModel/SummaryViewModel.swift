//
//  SummaryViewModel.swift
//  convey (iOS)
//
//  Created by Galen Quinn on 11/2/21.
//

import SwiftUI
import Combine

class SummaryViewModel : ObservableObject {
    
    @Published var recordList : [FirestoreRecord] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    private var firestoreService : FirestoreService
    private var authService : AuthService
    
    init(firestoreService : FirestoreService, authService : AuthService) {
        self.firestoreService = firestoreService
        self.authService = authService
        
        setupListeners()
    }
    
    func setupListeners() {
        
        
        firestoreService.userRecordsPublisher
            .sink { records in
                
                if records != nil {
                    self.recordList = records!
                }
                
                
            }.store(in: &cancellables)
    }
    
    func signOut() {
        
        authService.signOut()
        
    }
    
    func getFillerWordCount(topFreqFillerDict : [String : Int]) -> Int {
        
        
        var totalFillers = 0
        
        
        for fillerCount in topFreqFillerDict.values {
            totalFillers += fillerCount
        }
        
        return totalFillers
        
    }
    
    func roundPace(rec: FirestoreRecord) -> String {
        
        let wpm = rec.Wpm ?? 0.0
        
        let wpmRounded = wpm.rounded()
        
        return String(wpmRounded)
        
    }
    
    func getChartDataSet(rec : FirestoreRecord) -> BarChart.DataSet {
        
        var elements = [BarChart.DataSet.DataElement]()
        
        var index = 0
        
        for (fillerWord, fillerFreq) in rec.topFreqFillers ?? [ : ] {
            
            if index <= 5 {
                
                let label = "\"" + fillerWord + "\"" + " said " + String(fillerFreq) + " time(s)"
                
                elements.append(BarChart.DataSet.DataElement(date: nil, xLabel: label, bars: [BarChart.DataSet.DataElement.Bar(value: Double(fillerFreq), color: Color.orange)]))
                
                index += 1
                
            }
            
        }
        
        return BarChart.DataSet(elements: elements, selectionColor: Color.yellow)
        
        
        
        
    }
    
}
