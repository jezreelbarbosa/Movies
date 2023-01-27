import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // Properties

    var window: UIWindow?
//    var dependencyInjector: DependencyInjector!
//    var assembler: Assembler!
//    var appCoordinator: AppCoordinator!

    // Methods

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        LocalizedString.appLocale = Locale(identifier: "pt_BR")
        window = UIWindow(frame: UIScreen.main.bounds)
//        dependencyInjector = DependencyInjector(window: window)
//        dependencyInjector.build { [unowned self] assembler, appCoordinator in
//            self.assembler = assembler
//            self.appCoordinator = appCoordinator
//            appCoordinator.start()
//        }
        return true
    }
}
