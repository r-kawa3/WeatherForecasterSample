//
//  WeatherForecastResultRouter.swift
//  WeatherForecaster
//

import UIKit

protocol WeatherForecastResultWireframe: AnyObject {
    func showForecastDetail(_ forecast: Forecast)
}

final class WeatherForecastResultRouter {
    private unowned let viewController: UIViewController
    
    private init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    static func assembleModules() -> UIViewController {
        let storyboard = UIStoryboard(name: "WeatherForecastResult", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "WeatherForecastResult") as! WeatherForecastResultViewController
        let router = WeatherForecastResultRouter(viewController: view)
        let getForecastResultInteractor = GetForecastInteractor()
        let presenter = WeatherForecastResultPresenter(
            view: view,
            router: router,
            getForecastResultInteractor: getForecastResultInteractor
        )
        view.presenter = presenter
        
        return view
    }
}

extension WeatherForecastResultRouter: WeatherForecastResultWireframe {
    func showForecastDetail(_ forecast: Forecast) {
        let detailView = WeatherForecastDetailRouter.assembleModules(forecast: forecast)
        viewController.navigationController?.pushViewController(detailView, animated: true)
    }
}
