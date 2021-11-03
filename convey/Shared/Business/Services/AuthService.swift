//
//  AuthService.swift
//  MadRentals
//


import Firebase
import Combine

class AuthService {
    
    /// Fields
    
    var signedInChangePublisher = CurrentValueSubject<Bool, Never>(false)
    
    private var auth : Auth {
        Auth.auth()
    }
    
    var name : String {
        get {
            auth.currentUser?.displayName ?? "No Name"
        }
    }
    
    var email : String {
        get {
            auth.currentUser?.email ?? "No Email"
        }
    }
    
    var userId : String? {
        get {
            auth.currentUser?.uid
        }
    }
    
    private var authListener : AuthStateDidChangeListenerHandle? = nil
    
    private var firestoreService : FirestoreService
    
    /// Services initialization 
    
    init(firestoreService : FirestoreService) {
        self.firestoreService = firestoreService
        
        startListening()
    }
    
    /// Authentication Functions
    
    func signIn(username : String, password : String) {
        auth.signIn(withEmail: username, password: password, completion: { (result, error) in
            
            if error != nil {
                
                // alert user of error here
                
                return
            } else {
                
                print(result)
                
                // no error, proceed
                
            }
            
        })
    }
    
    func signOut() {
        
//        stopListening()
        
        firestoreService.stop()
        
        try! auth.signOut()
        
    }
    
    func signUp(email : String, password : String) {
        
        // creates user in firebase authentication
        auth.createUser(withEmail: email, password: password) { authResult, error in
            if error != nil {
                
                // alert user of error here
                
                return
            } else {
                
                if self.userId != nil {
                    
                    // creates user in firebase firestore
                    self.firestoreService.createUser(userId: self.userId!)
                    
                    print("Creating new user document in Firestore")
                } else {
                    fatalError("user id is null")
                }
                
                
//                self.firestoreService.create
                
                // no error, proceed
                
                
            }
        }
        
        
    }
    
    
    /// Authentication Listeners
    
    func startListening() {
        
        // if for some reason listener was already setup we stop the listener
        if (authListener != nil) {
            stopListening()
        }
        
        authListener = auth.addStateDidChangeListener { fireAuth, user in
            
            // if user is signed in
            if (fireAuth.currentUser != nil) {
                
                self.firestoreService.start(userID: fireAuth.currentUser!.uid)
                
                self.signedInChangePublisher.send(true)
                
                
            // if they are not signed in
            } else {
                
                self.signedInChangePublisher.send(false)
                
                self.firestoreService.stop()
            }
        }
    }
    
    func stopListening() {
        if (authListener != nil) {
            if let handle = authListener {
                auth.removeStateDidChangeListener(handle)
            }
            authListener = nil
        }
    }
    
    
    
}
