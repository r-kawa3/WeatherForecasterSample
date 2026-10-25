//
//  DetailViewController.swift
//  WeatherForecaster
//

import UIKit

protocol WeatherForecastDetailView: class {
    func updateWeatherForecastDetail(_ forecast: Forecast)
}

class WeatherForecastDetailViewController: UIViewController {
    
    var forecast:Forecast?
    
    var presenter: WeatherForecastDetailPresentation?
    
    @IBOutlet var dateLabel:UILabel!
    @IBOutlet var iconLabel:UILabel!
    @IBOutlet var weatherLabel:UILabel!
    @IBOutlet var descLabel:UILabel!
    @IBOutlet var tempLabel:UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewdidLoad()
    }

}

extension WeatherForecastDetailViewController: WeatherForecastDetailView {
    
    func updateWeatherForecastDetail(_ forecast: Forecast) {
        dateLabel.text = forecast.dt_txt
        iconLabel.text = forecast.getIconText()
        weatherLabel.text = forecast.getMain()
        descLabel.text = forecast.getDescription()
        tempLabel.text = forecast.getFormattedTemp()
    }
}
