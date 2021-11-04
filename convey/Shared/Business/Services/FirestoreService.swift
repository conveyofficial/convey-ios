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
    var userPublisher = CurrentValueSubject<FirestoreUser?, Never>(nil)
    var userID = ""
    
    
    func start(userID : String) {
        
        // this is where we must start up all of the relevant firestore listeners. we need snapshot listeners on users, apartments, etc, and all sorts of other listeners, whenever there is a change from a firestore listener, we must update a "Publisher" these are local listeners. For example, when we get the value for the value of a tenant, we must "publish" it using the "isTenantChangePublisher." I can explain this more. this is called reactive programming, for swift the framework we use is called Combine
        
        print("starting firestore")
        self.userID = userID
        startUserListener()
        
        // so first thing we do, is we grab all information about Users
        
        
    }
    
    
    func stop() {
        userID = ""
        userPublisher.send(nil)
    }
    
    
    // listens for changes in this person's firestore user data
    func startUserListener() {
        db.collection("users").document(userID)
            .addSnapshotListener { snapshot, err in
                
                
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    
                    
                    self.userPublisher.send(try? snapshot?.data(as: FirestoreUser.self))
                    
                }
                
            }
    }
    
    
    func createUser(userId : String) {
            
            
            try? db.collection("users").document(userId)
                .setData(from:
                            
                    FirestoreUser(
                        UserId: userID,
                        Records: []
                    )
                
                ) { [weak self] err in
                    guard let self = self else { return }
                    if let err = err {
                        print("err creating user... \(err)")
                        //self.yourErrorAlert()
                    }
                    else {
                        print("saved ok")
                      
                    }
                }
        }
}
