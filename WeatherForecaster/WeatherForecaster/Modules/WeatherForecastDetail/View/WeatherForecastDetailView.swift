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

        addAttributionButton()
        presenter?.viewdidLoad()
    }

    // OpenWeather の無料プランの条件にある出典表示。押すと openweathermap.org を開く
    private func addAttributionButton() {
        let button = UIButton(type: .system)
        button.setTitle("Weather data provided by OpenWeather", for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .footnote)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(openAttributionLink), for: .touchUpInside)
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])
    }

    @objc private func openAttributionLink() {
        guard let url = URL(string: "https://openweathermap.org/") else { return }
        UIApplication.shared.open(url)
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
