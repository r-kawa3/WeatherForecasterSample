//
//  WeatherForecastDetailPresenter.swift
//  WeatherForecaster
//

import Foundation

protocol WeatherForecastDetailPresentation: class {
    func viewdidLoad()
}

class WeatherForecastDetailPresenter {
    private weak var view: WeatherForecastDetailView?
    private let router: WeatherForecastDetailWireframe
    private let forecast: Forecast
    
    init( view: WeatherForecastDetailView,
          router: WeatherForecastDetailWireframe,
          forecast: Forecast
    ) {
        self.view = view
        self.router = router
        self.forecast = forecast
    }
}

extension WeatherForecastDetailPresenter: WeatherForecastDetailPresentation {
    func viewdidLoad() {
        view?.updateWeatherForecastDetail(forecast)
    }
}
