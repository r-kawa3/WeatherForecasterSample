//
//  AppRouter.swift
//  WeatherForecaster
//

import UIKit

protocol AppWireframe: AnyObject {
    func showWeatherForecastResultView()
}

final class AppRouter {
    private let window: UIWindow
    
    private init(window: UIWindow) {
        self.window = window
    }
    
    static func assembleModules(window: UIWindow) -> AppPresentation {
        let router = AppRouter(window: window)
        let presenter = AppPresenter(router: router)
        
        return presenter
    }
}

extension AppRouter: AppWireframe {
    func showWeatherForecastResultView() {
        let view = WeatherForecastResultRouter.assembleModules()
        let controller = UINavigationController(rootViewController: view)
        
        window.rootViewController = controller
        window.makeKeyAndVisible()
    }
}
