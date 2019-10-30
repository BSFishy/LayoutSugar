//
//  AppDelegate.swift
//  LayoutSugar
//
//  Created by Matt Provost on 10/25/2019.
//  Copyright (c) 2019 Matt Provost. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if #available(iOS 13.0, *) {} else {
            window = UIWindow(frame: UIScreen.main.bounds)
            let vc = ViewController()
            window?.rootViewController = vc
            window?.makeKeyAndVisible()
        }

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) { }
    func applicationDidEnterBackground(_ application: UIApplication) { }
    func applicationWillEnterForeground(_ application: UIApplication) { }
    func applicationDidBecomeActive(_ application: UIApplication) { }
    func applicationWillTerminate(_ application: UIApplication) { }
}

