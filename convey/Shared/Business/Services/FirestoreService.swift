//
//  FirestoreService.swift
//  convey
//


import Combine
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class FirestoreService {
    
    let db = Firestore.firestore()
    var userRecordsPublisher = CurrentValueSubject<[FirestoreRecord]?, Never>(nil)
    var userID = ""
    
    private var alertService : AlertService
    
    init(alertService : AlertService) {
        self.alertService = alertService
    }
    
    
    func start(userID : String) {
        
        print("starting firestore")
        self.userID = userID
        startUserListener()
        
        
    }
    
    
    func stop() {
        userID = ""
        userRecordsPublisher.send(nil)
    }
    
    
    
    func startUserListener() {
        db.collection("users")
            .document(userID)
            .collection("Records")
            .addSnapshotListener { snapshot, err in
                
                if let err = err {
                    
                    print("Error getting documents: \(err)")
                    
                } else {
                    
                    var recordsList = [FirestoreRecord]()
                    
                    if snapshot?.documents != nil {
                        
                        for document in snapshot!.documents {
                            
                            let record = try? document.data(as: FirestoreRecord.self)
                            
                            if record != nil {
                                
                                
                                if record!.topFreqFillers == nil {
                                    recordsList.append(record!)
                                } else {
                                    
                                    let sortedFillers = record!.topFreqFillers!.sorted { $0.value < $1.value }
                                    
                                    var sortedDict = [String : Int]()
                                    
                                    for (key, value) in sortedFillers {
                                        
                                        sortedDict[key] = value
                                        
                                    }
                                    
                                    print(sortedDict)
                                    
                                    recordsList.append(
                                        FirestoreRecord(
                                            RecordId: record!.RecordId,
                                            RecordName: record!.RecordName,
                                            ParsedText: record!.ParsedText,
                                            Time: record!.Time,
                                            WordCount: record!.WordCount,
                                            Wpm: record!.Wpm,
                                            fillerSet: record!.fillerSet,
                                            topFreqFillers: sortedDict,
                                            topFreqWords: record!.topFreqWords,
                                            wordFreq: record!.wordFreq,
                                            vocabGrade: record!.vocabGrade))
                                    
                                    
                                    
                                    
                                }
                                
                                
                           
                                
                                
                                
                                
                                
                            }
                            
                            
                            
                        }
                    }
                    
                    self.userRecordsPublisher.send(recordsList)
                }
                
            }
    }
    
    
    func createUser(userId : String, email : String) {
        
        
        try? db.collection("users")
            .document(userId)
            .setData(from:
                        
                        FirestoreUser(Email: email)
                     
            ) { err in
                
                if let err = err {
                    
                    print("err creating user... \(err)")
    
                }
                else {
                    print("saved ok")
                    
                }
            }
        
        
        
    }
    
    func uploadRecordToUser(text : String, time : Double, recordName : String) {
        
        
        
        var minutes = 0.0
        
        if time != 0.0 {
            
            minutes = time / 60.0
            
        }
        
        let textWords = Double(text.numberOfWords)
        
        print("MIN in UPUSRREC: \(minutes)")
        
        print("TEXTWORDS: \(textWords)")
        
        var wpm = 0.0
        
        if textWords != 0.0 {
            
            wpm = textWords / minutes
            
        }
        
        
        print("RECORDING TEXT")
        print(text)
        print(userID)
        
        let newRecord = FirestoreRecord(
            RecordName: recordName,
            ParsedText: text,
            Time: time,
            WordCount: text.numberOfWords,
            Wpm: wpm,
            fillerSet: nil,
            topFreqFillers: nil,
            topFreqWords: nil,
            wordFreq: nil
        )
        
        
        let error = try! db.collection("users")
            .document(userID)
            .collection("Records")
            .addDocument(from: newRecord) { [self] err in
                
                if let err = err {
                    
                    print("err adding transcription \(err)")
                    
                    
                    alertService.loadingPublisher.send(false)
                    
                    alertService.alertLoadingPublisher.send(true)
                    alertService.alertMessagePublisher.send(err.localizedDescription)
                    
                    
                }
                else {
                    
                    alertService.loadingPublisher.send(false)
                    
                    print("saved ok")
                    
                }
            }
        
        print(error)
        
    }
    
    
}
