//
//  AppModule.swift
//  convey
//



class AppModule {
    
    
    private static var authService : AuthService? = nil
    private static var firestoreService : FirestoreService? = nil
    private static var alertService : AlertService? = nil
    
    
    static func passAuthService() -> AuthService {
        
        authService = authService ?? AuthService(firestoreService: self.passFirestoreService())
        
        
        
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
