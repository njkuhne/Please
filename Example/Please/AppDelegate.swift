//
//  AppDelegate.swift
//  Please
//
//  Created by Nicholas Kuhne on 12/20/2016.
//  Copyright (c) 2016 Nicholas Kuhne. All rights reserved.
//

import UIKit
import Please

let imageURL = "https://image.freepik.com/free-icon/apple-logo_318-40184.jpg"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
		
		Please.cache(url: imageURL)
		
		return true
	}

}

