//
//  ViewModelModule.swift
//  MadRentals
//


import Foundation



// Similarly to the app module, this acts as a "viewmodel factory"

class ViewModelModule {
    
    
    private static var landingViewModel : LandingViewModel? = nil
    private static var signupViewModel : SignUpViewModel? = nil
    private static var signinViewModel : SignInViewModel? = nil
    private static var recordViewModel : RecordViewModel? = nil
    private static var summaryViewModel : SummaryViewModel? = nil
    
    static func passLandingViewModel() -> LandingViewModel {
        landingViewModel = landingViewModel ?? LandingViewModel(authService: AppModule.passAuthService(), firestoreService: AppModule.passFirestoreService(), alertService: AppModule.passAlertService())
        return landingViewModel!
    }
    static func passSignInViewModel() -> SignInViewModel {
        signinViewModel = signinViewModel ?? SignInViewModel(authService: AppModule.passAuthService(), alertService: AppModule.passAlertService())
        return signinViewModel!
    }
    static func passSignUpViewModel() -> SignUpViewModel {
        signupViewModel = signupViewModel ?? SignUpViewModel(authService: AppModule.passAuthService(), alertService: AppModule.passAlertService())
        return signupViewModel!
    }
    
    static func passSummaryViewModel() -> SummaryViewModel {
        summaryViewModel = summaryViewModel ?? SummaryViewModel(firestoreService: AppModule.passFirestoreService(), authService: AppModule.passAuthService())
        
        return summaryViewModel!
    }
    
    static func passRecordViewModel() -> RecordViewModel {
        recordViewModel = recordViewModel ?? RecordViewModel(firestoreService: AppModule.passFirestoreService(), authService: AppModule.passAuthService(), alertService: AppModule.passAlertService())
        
        return recordViewModel!
    }


    
    
    
    
}
