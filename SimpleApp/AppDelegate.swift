//
//  AppDelegate.swift
//  SimpleApp
//
//  Created by Francesco Puntillo on 07/11/2017.
//  Copyright © 2017 FP. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions
        launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()
        coordinator = AppCoordinator(sceneRoot: navigationController, services: ApplicationServices())
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        coordinator?.start()
        return true
    }
}
