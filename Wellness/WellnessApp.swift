//
//  WellnessApp.swift
//  Wellness
//
//  Created by Aarnav Dhir on 4/17/25.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        print("Firebase configured ✅")
        return true
    }
}

@main
struct WellnessApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @State private var showLaunchScreen = true

    var body: some Scene {
        WindowGroup {
            if showLaunchScreen {
                LaunchView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            showLaunchScreen = false
                        }
                    }
            } else {
                JoinScreen()
            }
        }
    }
}
