//
//  AppDelegate.swift
//  TaskR
//
//  Created by Jack Williams on 30/07/2018.
//  Copyright © 2018 Jack Williams. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        // print(Realm.Configuration.defaultConfiguration.fileURL)
    
        do {
            _ = try Realm()
            }
        catch {
            print("Error")
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

}

