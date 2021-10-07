//
//  AppDelegate.swift
//  Movies
//
//  Created by Jezreel Barbosa on 28/09/21.
//

import UIKit
import Common
import DI
import AppNavigation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // Properties

    var window: UIWindow?
//    var dependencyInjector: DependencyInjector!
//    var assembler: Assembler!
//    var appCoordinator: AppCoordinator!

    // Methods

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        window?.rootViewController = UIViewController()
        window?.makeKeyAndVisible()

//        dependencyInjector = DependencyInjector(window: window)
//        dependencyInjector.build(completion: { [unowned self] (assembler, appCoordinator) in
//            self.assembler = assembler
//            self.appCoordinator = appCoordinator
//            appCoordinator.start()
//        })

        return true
    }
}
