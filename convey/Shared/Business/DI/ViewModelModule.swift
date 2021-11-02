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
        landingViewModel = landingViewModel ?? LandingViewModel(authService: AppModule.passAuthService(), firestoreService: AppModule.passFirestoreService())
        return landingViewModel!
    }
    static func passSignInViewModel() -> SignInViewModel {
        signinViewModel = signinViewModel ?? SignInViewModel(authService: AppModule.passAuthService())
        return signinViewModel!
    }
    static func passSignUpViewModel() -> SignUpViewModel {
        signupViewModel = signupViewModel ?? SignUpViewModel(authService: AppModule.passAuthService())
        return signupViewModel!
    }
    
    static func passSummaryViewModel() -> SummaryViewModel {
        summaryViewModel = summaryViewModel ?? SummaryViewModel(firestoreService: AppModule.passFirestoreService())
        
        return summaryViewModel!
    }
    
    static func passRecordViewModel() -> RecordViewModel {
        recordViewModel = recordViewModel ?? RecordViewModel(firestoreService: AppModule.passFirestoreService())
        
        return recordViewModel!
    }

    
    
    
    
}
