//
//  FirestoreService.swift
//  MadRentals
//
//  Created by Galen Quinn on 10/4/21.
//  Trashed by Ting-Hung Lin on 10/6/21

import Combine
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class FirestoreService {
    
    let db = Firestore.firestore()
    var userRecordsPublisher = CurrentValueSubject<[FirestoreRecord]?, Never>(nil)
    var userID = ""
    
    
    func start(userID : String) {
        
        // this is where we must start up all of the relevant firestore listeners. we need snapshot listeners on users, apartments, etc, and all sorts of other listeners, whenever there is a change from a firestore listener, we must update a "Publisher" these are local listeners. For example, when we get the value for the value of a tenant, we must "publish" it using the "isTenantChangePublisher." I can explain this more. this is called reactive programming, for swift the framework we use is called Combine
        
        print("starting firestore")
        self.userID = userID
        startUserListener()
        
        
    }
    
    
    func stop() {
        userID = ""
        userRecordsPublisher.send(nil)
    }
    
    
    // listens for changes in this person's firestore user data
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
                                recordsList.append(record!)
                            }
                            
                            
                            
                        }
                    }
                    
                    self.userRecordsPublisher.send(recordsList)
                }
                
            }
    }
    
    
    func createUser(userId : String, email : String) {
            
            
            try? db.collection("users")
                .document(userId) // userId from Authentication
                .setData(from:
                            
                    FirestoreUser(Email: email)
                    
                    ) { err in
              
                    if let err = err {
                        
                        print("err creating user... \(err)")
                        //self.yourErrorAlert()
                    }
                    else {
                        print("saved ok")
                      
                    }
                }
        
        
        
        }
    
    func uploadRecordToUser(text : String, time : Double, recordName : String) {
        
        let wpm = text.numberOfWords / Int(time)
        
        // RecordName should be differnet here
        
        let newRecord = FirestoreRecord(
            RecordId: UUID().uuidString,
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
        
        
        let _ = try? db.collection("users")
            .document(userID)
            .collection("Records")
            .addDocument(data: newRecord.asDictionary()) { err in
            
                if let err = err {
                    
                    print("err adding transcription \(err)")
                    //self.yourErrorAlert()
                }
                else {
                    
                    print("saved ok")
                  
                }
            }
        
    }
    
    
}
