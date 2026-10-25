//
//  ViewController.swift
//  WeatherForecaster
//

import UIKit

protocol WeatherForecastResultView: AnyObject {
    func updateWeatherForecastResult(_ forecastResult: ForecastEntity)
    func printError()
}

class WeatherForecastResultViewController: UIViewController{
        
    private var forecasts = [Forecast]() {
        didSet {
            DispatchQueue.main.async { // メインスレッドで実行
                self.weatherTableView.reloadData()
            }
        }
    }
    
    @IBOutlet var weatherTableView:UITableView!
    
    var presenter: WeatherForecastResultPresentation!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        presenter?.viewWillAppear(cityName: "Tokyo")
    }
    
}

extension WeatherForecastResultViewController: WeatherForecastResultView {
    func updateWeatherForecastResult(_ forecastResult: ForecastEntity) {
        forecasts = forecastResult.list
    }
    
    func printError() {
        print("error")
    }
}

extension WeatherForecastResultViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell", for: indexPath)
        
        let timeLabel = cell.viewWithTag(1) as? UILabel
        timeLabel?.text = forecasts[indexPath.row].dt_txt
        
        let iconLabel = cell.viewWithTag(2) as? UILabel
        iconLabel?.text = forecasts[indexPath.row].getIconText()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelect(forecast: forecasts[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
}
