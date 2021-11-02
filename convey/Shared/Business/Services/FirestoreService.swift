//
//  FirestoreService.swift
//  MadRentals
//
//  Created by Galen Quinn on 10/4/21.
//  Trashed by Ting-Hung Lin on 10/6/21

import Foundation
import Combine
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class FirestoreService {
    
    let db = Firestore.firestore()
    
    var userPublisher = CurrentValueSubject<FirestoreUser?, Never>(nil)
    var appListPublisher = CurrentValueSubject<[FirestoreApplication]?, Never>(nil)
    var aptListPublisher = CurrentValueSubject<[FirestoreApartment]?, Never>(nil)
    var maintListPublisher = CurrentValueSubject<[FirestoreMaintenance]?, Never>(nil)
    var balancePublisher = CurrentValueSubject<String?, Never>(nil)
    
    
    
    //
    //    var dbMap = [
    //        "apartments": FirestoreApartment(),
    //        "applications": FirestoreApplication(),
    //        "maintenance": FirestoreMaintenance(),
    //        "users": FirestoreUser()
    //    ] as [String : Any]
    
    var userID = ""
    var aptID = ""
    
    
    func start(userID : String) {
        
        // this is where we must start up all of the relevant firestore listeners. we need snapshot listeners on users, apartments, etc, and all sorts of other listeners, whenever there is a change from a firestore listener, we must update a "Publisher" these are local listeners. For example, when we get the value for the value of a tenant, we must "publish" it using the "isTenantChangePublisher." I can explain this more. this is called reactive programming, for swift the framework we use is called Combine
        
        print("starting firestore")
        
        self.userID = userID
        
        startUserListener()
        
        // so first thing we do, is we grab all information about Users
        
        
        
        
    }
    
    
    
    
    func updateUserAptIdForApp(app : FirestoreApplication) {
        db.collection("apartments").whereField("name", isEqualTo: app.apt_name!)
            .getDocuments { snapshot, err in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    
                    for document in snapshot!.documents {
                        self.db.collection("users").document(app.user_id!)
                            .updateData(["apt_id" : document.documentID]) { err in
                                
                                if err != nil {
                                    print("error saving application status")
                                } else {
                                    print("successfully saved application status")
                                }
                                
                            }
                    }
                }
            }
    }
    
    
    func updateAptTenantId(app : FirestoreApplication) {
        db.collection("apartments").whereField("name", isEqualTo: app.apt_name!)
            .getDocuments { snapshot, err in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    
                    for document in snapshot!.documents {
                        self.db.collection("apartments").document(document.documentID)
                            .updateData(["tenant_id" : app.user_id!]) { err in
                                
                                if err != nil {
                                    print("error saving application status")
                                } else {
                                    print("successfully saved application status")
                                }
                                
                            }
                    }
                }
            }
    }
    
    func getAllMaintenance() {
        var listing = [FirestoreMaintenance]()
        
        db.collection("maintenance")
            .getDocuments { snapshot, err in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    
                    for document in snapshot!.documents {
                        listing.append(try! document.data(as: FirestoreMaintenance.self)!)
                    }
                    
                    self.maintListPublisher.send(listing)
                }
            }
    }
    
    
    func getAllApplications() {
        var listing = [FirestoreApplication]()
        
        db.collection("applications")
            .getDocuments { snapshot, err in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    
                    for document in snapshot!.documents {
                        listing.append(try! document.data(as: FirestoreApplication.self)!)
                    }
                    
                    self.appListPublisher.send(listing)
                }
            }
    }
    
    
    func stop() {
        userID = ""
        aptID = ""
        userPublisher.send(nil)
        appListPublisher.send(nil)
        aptListPublisher.send(nil)
        maintListPublisher.send(nil)
        balancePublisher.send(nil)
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
    
    func getApplicationListing() {
        
        
        var listing = [FirestoreApplication]()
        
        db.collection("applications").whereField("user_id", isEqualTo: userID)
            .getDocuments { snapshot, err in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    
                    for document in snapshot!.documents {
                        listing.append(try! document.data(as: FirestoreApplication.self)!)
                    }
                    
                    self.appListPublisher.send(listing)
                }
            }
    }
    
    

    
    
//    func start
    
    /*------------------------------------
     GET
     */
    func getData(collection: String, document: String) {
        
        db.collection(collection).document(document)
            .addSnapshotListener { snapshot, err in
                
                
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    
                    
                }
                
            }
    }
    
    
    // for tenants, get only the apartments that are empty == no tenant_id attached
    func getApartmentListingTenant() {
        
        
        var listing = [FirestoreApartment]()
        
        
        db.collection("apartments").whereField("tenant_id", isEqualTo: "")
            .getDocuments(completion: { snapshot, err in
                
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    
                    //                        let aptList = snapshot?.documents
                    
                    for document in snapshot!.documents {
                        
                        listing.append(try! document.data(as: FirestoreApartment.self)!)
                        
                    }
                    
                    self.aptListPublisher.send(listing)
                    
                    
                    //                    for document in querySnapshot!.documents {
                    //                        // constuct apartment object, put in [listing] var
                    //                            listing.append(document.data())
                    
                    //                        // print("\(document.documentID) => \(document.data())")
                    //                    }
                    
                    
                }
            })
    }
    
    // for owners, get the apartments under their id
    func getApartmentListingOwner(ownerID : String) {
        
        var listing = [FirestoreApartment]()
        
        db.collection("apartments").whereField("owner_id", isEqualTo: ownerID)
            .getDocuments { snapshot, err in
                
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    
                    for document in snapshot!.documents {
                        // constuct apartment object, put in [listing] var
                        listing.append(try! document.data(as: FirestoreApartment.self)!)
                        // print("\(document.documentID) => \(document.data())")
                    }
                    
                    self.aptListPublisher.send(listing)
                    
                }
                
            }
    }
    
    /*
     get multiple documents listing in collection with specified codition
     
     Use case for Tenants:
     1. {apartments}:
     tenant_id == "" (to show available apts)
     2. {applications}:
     user_id == 'theirs_user_id'
     3. {maintenance}: SEE TODO ADD FIELD
     apt_id == {users}[apt_id]
     
     Use case for Owners
     1. {apartments}:
     owner_id == 'theirs_owner_id'
     2. {applications}:
     owner_id == 'theirs_owner_id'
     3. {maintenance}: SEE TODO ADD FIELD
     apt_id == for apt_id in {users}[apt_id] (owners could have multi apt under their name)
//     */
//    func getListingCondition<T>(collection:String, fieldCondition: String, valueCondition: T) {
//
//        let listing = []
//
//        db.collection(collection).whereField(fieldCondition, isEqualTo: valueCondition)
//            .getDocument(){ (querySnapshot, err) in
//                if let err = err {
//                    print("Error getting documents: \(err)")
//                } else {
//
//                    for document in querySnapshot!.documents {
//                        // constuct apartment object, put in [listing] var
//                        listing.append(document.data(as: dbMap[collection]))
//                        // print("\(document.documentID) => \(document.data())")
//                    }
//                }
//                return listing
//            }
//    }
    
    
    // normal get everything!!!
    func getApartmentListing() {
        
        var listing = [FirestoreApartment]()
        
        db.collection("apartments")
            .getDocuments{ snapshot, err in
                
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    
                    for document in snapshot!.documents {
                        // constuct apartment object, put in [listing] var
                        listing.append(try! document.data(as: FirestoreApartment.self)!)
                        // print("\(document.documentID) => \(document.data())")
                    }
                    
                    
                }
            }
    }
    

    
    func getRentForProperty(aptId : String) {
        
//        print(aptId)
        
        db.collection("apartments").document(aptId)
            .getDocument { snapshot, err in
                
//                print(snapshot?.data())
                
                
                
                
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    
                    let apt = try! snapshot!.data(as: FirestoreApartment.self)
                    
//                    print(apt)
                    
//                    if apt != nil {
                    
                    self.balancePublisher.send(String(apt!.balance!))
              
                    
                    
                }
                
            }
    }
    

    
    
    
    
    func acceptMaintenance(maint : FirestoreMaintenance) {
        db.collection("maintenance").document(maint.id!)
            .updateData(["status": 1]) { err in
                
                if err != nil {
                    print("error updating balance")
                }
                
            }
    }
    
    func acceptApplication(app : FirestoreApplication) {
        
    }
    
    func updateApplicationStatus(app : FirestoreApplication, status : Int) {
        db.collection("applications").document(app.id!)
            .updateData(["status" : status]) { err in
                
                if err != nil {
                    print("error saving application status")
                } else {
                    print("successfully saved application status")
                }
                
            }
        
    }
    
    func updateBalance(aptId : String, newBalance : Int) {
        db.collection("apartments").document(aptId)
            .updateData(["balance": newBalance]) { err in
                
                if err != nil {
                    print("error updating balance \(err)")
                }
                
            }
    }
    
    func getBalanceGivenName(aptName : String) {
        
        print(aptName)
        
        db.collection("apartments").whereField("name", isEqualTo: aptName).getDocuments { snapshot, err in
            
            
            
            if err != nil {
                print("error updating balance given name")
            } else {
                
                let document = try! snapshot!.documents.first!.data(as: FirestoreApartment.self)
                
                print(document)
                
                let bal = String(document!.balance!)
                
                self.balancePublisher.send(bal)
                
                
            }
            
        }
    }
    
    func updateBalanceGivenName(aptName : String, newBalance : Int) {
        
        db.collection("apartments").whereField("name", isEqualTo: aptName).getDocuments { snapshot, err in
            
            if err != nil {
                print("error updating balance given name")
            } else {
                
                let document = try! snapshot!.documents.first!.data(as: FirestoreApartment.self)
                
                print(document)
                
                
                
                self.updateBalance(aptId: document!.apt_id!, newBalance: newBalance)
                
                
            }
            
        }
    }
    
    
    
    //  UPDATE
    
    /*
     update one field
     Use case for "apartment" collection:
     1. update balance for both tenant and owner
     2. update tenant id once owner approves
     
     Use case for "application" collection:
     1. update status (pending 0, reject 1, approve 2) SEE ToDo
     
     Use case for "maintenance" collection:
     1. update status (pending 0, working 1, reject 2, done 3)
     
     Use case for "users" collection:
     1. update apt_id_applied
     2. update apt_id
     */
    func updateSingleData(collection:String, document: String, field: String, newValue: Any ) {
        
        db.collection(collection).document(document)
            .setData([field:newValue], merge:true) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    
    
    
    // general function for creating new row of data entry
    func createData(collection:String, document: String, data: Dictionary<String, Any>) {
        for (field,value) in data {
            updateSingleData(collection: collection, document: document, field: field, newValue: value)
        }
    }
    
    
    // adapted general function for creating new document given a generic "Codable" object
    func createDocument<T : Codable>(collection:String, document: String, data: T) {
        
        let _ = try? db.collection(collection).document(document)
            .setData(from: data) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
        
    }
    
    // adapted general function for creating new document given a generic "Codable" object
    func createDocument<T : Codable>(collection:String, data: T) {
        
        let _ = try? db.collection(collection).addDocument(from: data) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
        
    }
    
//    // adapted general function for creating new document given a generic "Codable" object
//    func createApplicationt(data: FirestoreApplication) {
//        
//        let _ = try? db.collection("users").document(userID)
//            .setData(from: data) { err in
//            if let err = err {
//                print("Error updating document: \(err)")
//            } else {
//                print("Document successfully updated")
//            }
//        }
//        
//    }
    
    
    
    // owner type 1; tenant type 0
    func createUser(userId : String, userType : Bool) {
        
        
        try? db.collection("users").document(userId)
            .setData(from:
                        
                FirestoreUser(
                    apt_applied: "",
                    apt_id: "",
                    is_owner: userType,
                    user_id: userID
                )
            
            ) { [weak self] err in
                guard let self = self else { return }
                if let err = err {
                    print("err creating user... \(err)")
                    //self.yourErrorAlert()
                }
                else {
                    print("saved ok")
                    
                    // you just created a user so the apartment ID will be nil since you don't belong to a property
                    self.aptID = ""
                  
                }
            }
    }
    
    /*
     TODO:
     1. change {user} [apt_applied]  to a list
     2. ADD [status] for {application} (pending 0, reject 1, approve 2)
     3. ADD [apt_id] for {maintenance} (for linking)
     */
}
