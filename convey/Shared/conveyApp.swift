//
//  conveyApp.swift
//  Shared
//
//  Created by Galen Quinn on 11/1/21.
//

import SwiftUI

@main
struct conveyApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            LandingView()
        }
    }
}
