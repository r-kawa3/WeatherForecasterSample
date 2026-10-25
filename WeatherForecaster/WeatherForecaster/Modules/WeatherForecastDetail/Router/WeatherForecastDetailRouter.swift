//
//  WeatherForecastDetailRouter.swift
//  WeatherForecaster
//

import UIKit

protocol WeatherForecastDetailWireframe: class {
    
}

final class WeatherForecastDetailRouter {
    private unowned let viewController: UIViewController
    
    private init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    static func assembleModules(forecast: Forecast) -> UIViewController {
        let storyboard = UIStoryboard(name: "WeatherForecastDetail", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "WeatherForecastDetail") as! WeatherForecastDetailViewController
        let router = WeatherForecastDetailRouter(viewController: view)
        let presenter = WeatherForecastDetailPresenter(view: view, router: router, forecast: forecast)
        
        view.presenter = presenter
        
        return view
    }
}

extension WeatherForecastDetailRouter: WeatherForecastDetailWireframe {
    
}
