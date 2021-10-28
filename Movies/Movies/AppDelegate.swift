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
import Swinject
import UIComponents

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // Properties

    var window: UIWindow?
    var dependencyInjector: DependencyInjector!
    var assembler: Assembler!
    var appCoordinator: AppCoordinator!

    // Methods

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        LocalizedString.appLocale = Locale(identifier: "en_US")
        window = UIWindow(frame: UIScreen.main.bounds)
        dependencyInjector = DependencyInjector(window: window)
        dependencyInjector.build { [unowned self] assembler, appCoordinator in
            self.assembler = assembler
            self.appCoordinator = appCoordinator
            appCoordinator.start()
        }
        return true
    }
}
