//
//  AppDelegate.swift
//  MarvelCharacters
//
//  Created by Ivo Dutra on 11/08/20.
//  Copyright © 2020 Ivo Dutra. All rights reserved.
//

import UIKit

// TODO: escolher foto para appIcon

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let navigationController = UINavigationController(rootViewController: CharactersViewController(name: "test"))

        // Remove Main.storyboard dependency
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        return true
    }

}

