import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = .init(frame: UIScreen.main.bounds)
        AppCoordinator.shared.configure()
        AppCoordinator.shared.launch(window: window)
        return true
    }

    func applicationDidFinishLaunching(_ application: UIApplication) {
        application.setMinimumBackgroundFetchInterval(3600)
    }

    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        BackgroundWorkManager.shared.start(completion: completionHandler)
    }

}
