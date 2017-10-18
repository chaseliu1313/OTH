//
//  AppDelegate.swift
//  On the House
//
//  Created by Geng Xu on 2017/8/21.
//  Copyright © 2017年 Geng Xu. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var storyboard : UIStoryboard?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        SDKApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        PayPalMobile .initializeWithClientIds(forEnvironments: [PayPalEnvironmentProduction: "access_token$production$ppkqf9k6pyrv68fj$862e5c7e5dc3849bce60e7484dc963b6",
                                                                PayPalEnvironmentSandbox: "irenameister@gmail.com"])
        /*PayPalMobile .initializeWithClientIds(forEnvironments: [PayPalEnvironmentProduction: "access_token$production$ppkqf9k6pyrv68fj$862e5c7e5dc3849bce60e7484dc963b6",
                                                                PayPalEnvironmentSandbox: "irenameister@gmail.com"])*/
        
        let isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
        
        self.storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        if isLoggedIn {
            self.window?.rootViewController = self.storyboard?.instantiateViewController(withIdentifier: "offer")
            
        }
        else{
            self.window?.rootViewController = self.storyboard?.instantiateViewController(withIdentifier: "login")
        }
        
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
    
    
}

