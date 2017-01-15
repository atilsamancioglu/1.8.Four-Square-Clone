//
//  AppDelegate.swift
//  Foursquare Clone
//
//  Created by Atıl Samancıoğlu on 19/12/2016.
//  Copyright © 2016 Atıl Samancıoğlu. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let config = ParseClientConfiguration { (ParseMutableClientConfiguration) in
            
            ParseMutableClientConfiguration.applicationId = "9f8c3f167f262200bfd6ce9e5ac86779c340b591"
            ParseMutableClientConfiguration.clientKey = "87082a47c785b946d5daa6c7cb42abe8ce097694"
            ParseMutableClientConfiguration.server = "http://ec2-35-161-66-134.us-west-2.compute.amazonaws.com:80/parse"
    
        }
        
        
        Parse.initialize(with: config)
        
        let defaultACL = PFACL()
        defaultACL.getPublicReadAccess = true
        defaultACL.getPublicWriteAccess = true
    
        
        rememberLogin()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    
    func rememberLogin() {
        
        let user : String? = UserDefaults.standard.string(forKey: "userinfo")
        
        if user != nil {
            
            let board : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            
            let navigationController = board.instantiateViewController(withIdentifier: "navigationVC") as! UINavigationController
            
            window?.rootViewController = navigationController
            
        }
        
    }
    
}

