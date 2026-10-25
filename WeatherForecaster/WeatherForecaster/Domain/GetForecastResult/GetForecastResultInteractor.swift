//
//  GetForecastResultInteractor.swift
//  WeatherForecaster
//

import Foundation

protocol GetForecastUsecase: AnyObject {
    func fetchForecastResult(cityName: String, appId: String, completion: @escaping (Result<ForecastEntity, Error>) -> Void)
}

final class GetForecastInteractor {
    
    private let client: OpenWeatherMapRequestable
    
    init(client: OpenWeatherMapRequestable = OpenWeatherMapClient()) {
        self.client = client
    }
}

extension GetForecastInteractor: GetForecastUsecase {
    func fetchForecastResult(cityName: String, appId: String, completion: @escaping (Result<ForecastEntity, Error>) -> Void) {
        let request = OpenWeatherMapAPI.GetForecastResult(cityName: cityName, appId: appId)
        print(request)
        client.send(request: request){ result in
            completion(result)
        }
    }
}
