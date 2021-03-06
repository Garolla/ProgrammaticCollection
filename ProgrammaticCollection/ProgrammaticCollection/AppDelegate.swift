//
//  AppDelegate.swift
//  ProgrammaticCollection
//
//  Created by Emanuele Garolla on 22/11/2020.
//

import UIKit
//TODO: import GoogleMaps pod and key. Then uncomment
//import GoogleMaps

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        GMSServices.provideAPIKey(Constants.GOOGLE_MAPS_KEY)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        // Create a view controller
        let viewController = RestaurantVC()
        // Assign the view controller as `window`'s root view controller
        window?.rootViewController = viewController
        // Show the window
        window?.makeKeyAndVisible()

        return true
    }
}

