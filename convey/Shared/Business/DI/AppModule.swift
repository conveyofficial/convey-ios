//
//  AppModule.swift
//  MadRentals
//



// This class is pretty much a "Service Factory"
// This is used to make sure that we are only using one service at a time, and so that we aren't accessing services or other classes in an infinite loop

class AppModule {
    
    
    
    // We initialize our services to "nil" which is just null.
    // A variable can only be assigned to nil if it is an optional
    // optional variables have the ? at the end
    // if a variable is not optional and assigned nil it will crash the app
    
    private static var authService : AuthService? = nil
    private static var firestoreService : FirestoreService? = nil
    private static var alertService : AlertService? = nil
    
    
    static func passAuthService() -> AuthService {
        
        // To deal with optionals, we must either force unwrap the variable,
        // or give it a default value if is nil
        
        // we give optionals default values with ??
        // This statement basically makes it so that an authservice is either there or it is nil,
        // if it is nil we create a new AuthService class and assign it to our variable stored in here called authService
        authService = authService ?? AuthService(firestoreService: self.passFirestoreService())
        
        
        // here we know that we will never have a nil value, so we can force unwrap it
        return authService!
    }
    
    
    
    static func passFirestoreService() -> FirestoreService {
        
        firestoreService = firestoreService ?? FirestoreService(alertService: self.passAlertService())
        
        return firestoreService!
    }
    
    static func passAlertService() -> AlertService {
        
        alertService = alertService ?? AlertService()
        
        return alertService!
    }
    
    
    
    
}
