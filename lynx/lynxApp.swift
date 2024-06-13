//
//  lynxApp.swift
//  lynx
//
//  Created by Arnav Wadehra on 6/14/22.
//

import SwiftUI
import Firebase
import FirebaseAuth
import Stripe


@main
struct lynxApp: App {
    @ObservedObject var appState = AppState()
    init() {
      FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(MainViewModel.shared).environmentObject(appState)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        StripeAPI.defaultPublishableKey = "pk_test_51KhRpTByADKDQsmx5VBxZBa3TnXCkZjBxeRDNTyrSZPN7UobXk6yeJbEpioILubwSKoKaE3JWQigK2T1xOAfzqpQ000sChpxvi"
        return true
    }
    
    static var orientationLock =
    UIInterfaceOrientationMask.portrait

    func application(_ application: UIApplication,
    supportedInterfaceOrientationsFor window:
    UIWindow?) -> UIInterfaceOrientationMask {
    return AppDelegate.orientationLock
    }
    
}
