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
    
    private var authListener : AuthStateDidChangeListenerBlock? = nil
    private var handle : AuthStateDidChangeListenerHandle? = nil
    
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
        
//        firestoreService.stop()
        
        try! auth.signOut()
        
    }
    
    func signUp(email : String, password : String) {
        
        // creates user in firebase authentication
        auth.createUser(withEmail: email, password: password) { authResult, error in
            if error != nil {
                
                print("Error signing up")

            } else {
                
                if self.userId != nil {
                    
                    // creates user in firebase firestore
                    self.firestoreService.createUser(userId: self.userId!, email: email)
                    
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
        
        authListener = { fireAuth, _ in
            
            if (fireAuth.currentUser != nil) {
                
                self.firestoreService.start(userID: fireAuth.currentUser!.uid)
                
                self.signedInChangePublisher.send(true)
                
                
            } else {
                
                
                self.signedInChangePublisher.send(false)
                
                self.firestoreService.stop()
                
            }
        }
 
        
        handle = auth.addStateDidChangeListener(authListener!)
        
    }
    
    func stopListening() {
        if (authListener != nil && handle != nil) {
            
            auth.removeStateDidChangeListener(handle!)
            
            authListener = nil
            handle = nil
        }
    }
    
    
    
}
