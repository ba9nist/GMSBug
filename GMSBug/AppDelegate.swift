//
//  AppDelegate.swift
//  GMSBug
//
//  Created by Yevhenii Boryspolets on 29.10.2020.
//

import UIKit
import GooglePlaces
import GoogleMaps

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let token = "YOUR key"
        GMSServices.provideAPIKey(token)
        GMSServices.setAbnormalTerminationReportingEnabled(false)
        GMSPlacesClient.provideAPIKey(token)
        
        let controller = ViewController()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
        
        return true
    }

}

