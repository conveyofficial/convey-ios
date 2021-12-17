//
//  AppDelegate.swift
//  convey
//
//  Created by Galen Quinn on 11/2/21.
//

import UIKit
import Firebase


class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        print("Firebase Configured")
        
        return true
        
    }
}
