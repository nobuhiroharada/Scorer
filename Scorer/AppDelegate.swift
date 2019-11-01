//
//  AppDelegate.swift
//  Scorer
//
//  Created by Nobuhiro Harada on 2019/10/11.
//  Copyright © 2019 Nobuhiro Harada. All rights reserved.
//

import UIKit

let userdefaults = UserDefaults.standard

var isLandscape: Bool {
    return UIApplication.shared.windows
        .first?
        .windowScene?
        .interfaceOrientation
        .isLandscape ?? false
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private(set) lazy var viewController = MainViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if (userdefaults.object(forKey: Consts.BUZEER_AUTO_BEEP) == nil) {
            userdefaults.set(false, forKey: Consts.BUZEER_AUTO_BEEP)
        }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }


}

