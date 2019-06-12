//
//  AppDelegate.swift
//  Kcal
//
//  Created by Ahmed Durrani on 05/02/2019.
//  Copyright © 2019 TeachEase Solution. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import CoreLocation
import GoogleMaps
import GooglePlaces
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        GMSServices.provideAPIKey("AIzaSyCCxD_sQIJNvXdfGsp7eiTVb36nEDHtAA0")
        GMSPlacesClient.provideAPIKey("AIzaSyCCxD_sQIJNvXdfGsp7eiTVb36nEDHtAA0")
        
        GIDSignIn.sharedInstance().clientID = "894730141413-24i2ao1sbtmf7oscfs05sfjfjsu03o5r.apps.googleusercontent.com"

//        AIzaSyCCxD_sQIJNvXdfGsp7eiTVb36nEDHtAA0
        
//        AIzaSyD0L3g799C_ovzkcR4IpCRfenwoCKmVIQs
        
        IQKeyboardManager.shared.enable = true
        
        _ =  Location.getLocation(withAccuracy:.block, frequency: .oneShot, onSuccess: { [weak self] location in
            //            print("loc \(location.coordinate.longitude)\(location.coordinate.latitude)")
            DEVICE_LAT = location.coordinate.latitude
            DEVICE_LONG = location.coordinate.longitude
            
            let geoCoder = CLGeocoder()
            let location = CLLocation(latitude: DEVICE_LAT, longitude: DEVICE_LONG)
            
            geoCoder.reverseGeocodeLocation(location, completionHandler: { [weak self] placemarks, error in
                guard let addressDict = placemarks?[0].addressDictionary else {
                    return
                }
                
                // Print each key-value pair in a new row
                addressDict.forEach { print($0) }
                
                // Print fully formatted address
                if let formattedAddress = addressDict["FormattedAddressLines"] as? [String] {
                    //                    print(formattedAddress.joined(separator: ", "))
                    DEVICE_ADDRESS = formattedAddress.joined(separator: ", ")
                    
//                    let zipCode =  formattedAddress.joined(separator: "postalCode")
//                    print(zipCode)
//                    open var name: String? { get } // eg. Apple Inc.
//
//                    open var thoroughfare: String? { get } // street name, eg. Infinite Loop
//
//                    open var subThoroughfare: String? { get } // eg. 1
//
//                    open var locality: String? { get } // city, eg. Cupertino
//
//                    open var subLocality: String? { get } // neighborhood, common name, eg. Mission District
//
//                    open var administrativeArea: String? { get } // state, eg. CA
//
//                    open var subAdministrativeArea: String? { get } // county, eg. Santa Clara
//
//                    open var postalCode: String? { get } // zip code, eg. 95014
//
//                    open var isoCountryCode: String? { get } // eg. US
//
//                    open var country: String? { get } // eg. United States
//
//                    open var inlandWater: String? { get } // eg. Lake Tahoe
//
//                    open var ocean: String? { get } // eg. Pacific Ocean
//
//                    open var areasOfInterest: [String]? { get } // eg. Golden Gate Park

                    
                    
                    //                    self?.address = formattedAddress.joined(separator: ", ")
                    
                    
                    
                }
            })
            
            }, onError: { (last, error) in
                print("Something bad has occurred \(error)")
        })

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

