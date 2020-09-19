//
//  AppDelegate.swift
//  NIBM COVID19
//
//  Created by Ruvinda Lahiru Samaranayake on 9/12/20.
//  Copyright © 2020 Ruvinda Lahiru Samaranayake. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        tryAutoLogin()
        NSSetUncaughtExceptionHandler { exception in
           print(exception)
           print(exception.callStackSymbols)
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func tryAutoLogin(){
        let email = UserDefaults.standard.string(forKey: "email")
        let password = UserDefaults.standard.string(forKey: "password")

        if(email == "null" || email == nil){
            UserDefaults.standard.set(false, forKey: "is_logged")
            return
        }
        
        Auth.auth().signIn(withEmail: email!, password: password!) { [weak self] authResult, error in
          guard let strongSelf = self else { return }
            
            if(error != nil) {
                UserDefaults.standard.set("null", forKey: "id")
                UserDefaults.standard.set("null", forKey: "email")
                UserDefaults.standard.set("null", forKey: "password")
                UserDefaults.standard.set(false, forKey: "is_logged")
                
                return
            }
            
            UserDefaults.standard.set(true, forKey: "is_logged")
        }
    }


}

