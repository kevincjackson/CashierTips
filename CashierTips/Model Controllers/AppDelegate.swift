//
//  AppDelegate.swift
//  CashierTips
//
//  Created by Kevin Jackson on 4/4/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var stateController = StateController(storageController: StorageController())

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Inject World State
        let navVC = window?.rootViewController as! UINavigationController
        let mainVC = navVC.viewControllers.first as! MainViewController
        mainVC.stateController = stateController
        
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        stateController.save()
    }

}

