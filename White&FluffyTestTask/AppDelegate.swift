
//
//  AppDelegate.swift
//  WhiteAndFluffyTestTask
//
//  Created by Мехрафруз on 01.04.2021.
//  Copyright © 2021 Мехрафруз. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let weatherContext = WeatherContext()
        let weatherContainer = WeatherContainer.assemble(with: weatherContext)
        
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = weatherContainer.viewController
        window?.makeKeyAndVisible()
        return true
    }


}

