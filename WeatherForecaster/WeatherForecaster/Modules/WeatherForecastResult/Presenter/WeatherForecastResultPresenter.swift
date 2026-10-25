//
//  WeatherForecastResultPresenter.swift
//  WeatherForecaster
//

import Foundation

protocol WeatherForecastResultPresentation {
    func viewWillAppear(cityName: String)
    func didSelect(forecast: Forecast)
}

class WeatherForecastResultPresenter {
    private weak var view: WeatherForecastResultView?
    private let router: WeatherForecastResultWireframe
    private let getForecastResultInteractor: GetForecastUsecase
    
    init (view: WeatherForecastResultView,
          router: WeatherForecastResultWireframe,
          getForecastResultInteractor: GetForecastInteractor) {
        self.view = view
        self.router = router
        self.getForecastResultInteractor = getForecastResultInteractor
    }
}

extension WeatherForecastResultPresenter: WeatherForecastResultPresentation {
    func viewWillAppear(cityName: String) {
        guard !cityName.isEmpty else {
            return
        }
        getForecastResultInteractor.fetchForecastResult(cityName: cityName, appId: OpenWeatherMapAPI.apiKey){ [weak self] result in
            switch result {
            case .success(let forecastResult):
                self?.view?.updateWeatherForecastResult(forecastResult)
            case .failure:
                self?.view?.printError()
            }
        }
    }
    
    func didSelect(forecast: Forecast) {
        router.showForecastDetail(forecast)
    }
}
