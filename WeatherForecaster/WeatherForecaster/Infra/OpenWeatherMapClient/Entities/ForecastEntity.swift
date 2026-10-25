//
//  ForecastEntity.swift
//  WeatherForecaster
//

import Foundation

struct ForecastEntity: Decodable {
    var list:[Forecast]
}

struct Forecast: Decodable {
    var dt_txt:String
    var main:Main
    var weather:[Weather]
    
    struct Main: Decodable {
        var temp: Double
    }
    
    struct Weather: Decodable {
        var description: String
        var id: Int
        var main: String
    }
    
    func getFormattedTemp() -> String{
        return String(format: "%.1f ℃", main.temp)
    }
    
    func getDescription() -> String{
        return weather.count > 0 ? weather[0].description : "" // 三項演算子
    }
    
    func getIconText() -> String {
        if weather.count == 0 {
            return ""
        }
        // 次を参考: https://openweathermap.org/weather-conditions
        switch weather[0].id {
        case 200..<300: return "⚡️"
        case 300..<400: return "🌫"
        case 500..<600: return "☔️"
        case 600..<700: return "⛄️"
        case 700..<800: return "🌪"
        case 800: return "☀️"
        case 801..<900: return "☁️"
        case 900..<1000: return "🌀"
        default: return "☁️"
        }
    }
    
    func getMain() -> String {
        return weather.count > 0 ? weather[0].main : ""
    }
}
