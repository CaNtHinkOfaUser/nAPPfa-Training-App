//
//  Napha_Training_AppApp.swift
//  Napha Training App
//
//  Created by Kui Jun on 24/5/24.
//

import SwiftUI

@main

struct Napha_Training_AppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    class AppDelegate: NSObject, UIApplicationDelegate {
            
        static var orientationLock = UIInterfaceOrientationMask.all //By default you want all your views to rotate freely

        func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
            return AppDelegate.orientationLock
        }
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
