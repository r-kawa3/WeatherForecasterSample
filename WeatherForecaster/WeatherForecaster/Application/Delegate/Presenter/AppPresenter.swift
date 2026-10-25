//
//  AppPresenter.swift
//  WeatherForecaster
//

import Foundation

protocol AppPresentation: AnyObject {
    func didFinishLaunch()
}

final class AppPresenter {
    private let router: AppWireframe
    
    init(router: AppWireframe) {
        self.router = router
    }
}

extension AppPresenter: AppPresentation {
    func didFinishLaunch() {
        router.showWeatherForecastResultView()
    }
}
