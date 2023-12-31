
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        let dateService = DateServiceImpl()
        let viewModel = TodoItemViewModel(fileCache: FileCacheImpl())
        let viewController = TodoItemViewController(viewOutput: viewModel, dateService: dateService)
        let navigationController = UINavigationController(rootViewController: viewController)
        window = UIWindow()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        return true
    }

}
