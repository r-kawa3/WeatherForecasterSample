//
//  OpenWeatherMapAPI.swift
//  WeatherForecaster
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

protocol OpenWeatherMapRequest {
    associatedtype Response: Decodable
    
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem] { get }
}

extension OpenWeatherMapRequest {
    var baseURL: URL {
        return URL(string: "http://api.openweathermap.org/data/2.5")!
    }
    
    func buildURLRequest() -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = queryItems
        
        var urlRequest = URLRequest(url: url)
        urlRequest.url = components?.url
        urlRequest.httpMethod = method.rawValue
        
        return urlRequest;
    }
    
    func response(from data: Data, urlResponse: URLResponse) throws -> Response {
        let decoder = JSONDecoder()
        
        if case (200..<300)? = (urlResponse as? HTTPURLResponse)?.statusCode {
            return try decoder.decode(Response.self, from: data)
        } else {
            throw NSError()
        }
    }
}

final class OpenWeatherMapAPI {
    
    /// Config/Secrets.xcconfig の OPENWEATHERMAP_API_KEY が Info.plist 経由で入る
    static var apiKey: String {
        return Bundle.main.object(forInfoDictionaryKey: "OpenWeatherMapAPIKey") as? String ?? ""
    }
    
    struct GetForecastResult: OpenWeatherMapRequest {
        
        typealias Response = ForecastEntity
        
        let cityName: String
        
        let appId: String
        
        var method: HTTPMethod {
            return .get
        }
        
        var path: String {
            return "/forecast"
        }
        
        var queryItems: [URLQueryItem] {
            return [URLQueryItem(name: "units", value: "metric"),
                    URLQueryItem(name: "q", value: cityName),
                    URLQueryItem(name: "APPID", value: appId)
            ]
        }
    }
}
