//
//  ViewController.swift
//  Lab3
//
//  Created by Howard Barde on 11/2/24.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var weatherConditionImage: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var isCelcius: UISwitch!
    @IBOutlet weak var condition: UILabel!
    var tempCelcius: String?
    var tempFaren: String?
    
    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        isCelcius.isEnabled = false
        locationManager.delegate = self
    }
    
    @IBAction func onSearchPressed(_ sender: UIButton) {
        loadWeather(search: searchTextField.text)
    }
    @IBAction func onLocationPressed(_ sender: UIButton) {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        //loadWeather(search: locationLabel.text)
    }
 
    @IBAction func toggleTemp(_ sender: UISwitch) {
        if (isCelcius.isOn) {
            temperatureLabel.text = tempCelcius
        } else {
            temperatureLabel.text = tempFaren
        }
    }
    
    private func displayImage() {
        let config = UIImage.SymbolConfiguration(paletteColors: [.systemRed, .systemBlue, .systemGreen, .systemOrange, .systemYellow, .systemPurple])
        
        weatherConditionImage.preferredSymbolConfiguration = config
        weatherConditionImage.image = UIImage(systemName: "rainbow")
    }
    
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loadWeather(search: searchTextField.text)
        textField.endEditing(true)
        return true
    }
    
    private func loadWeather(search: String?) {
        guard let search = search else {
            return
        }
        
//        if (isCurrentLocation == 1) {
//            search = "auto:ip"
//        }
        
        isCelcius.isEnabled = true
        
        guard let url = getURL(query: search) else {
            print("Could not get URL")
            return
        }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { data, response, error in
            print("Network call complete")
            
            guard error == nil else {
                print("Received error")
                return
            }
            
            guard let data = data else {
                print("No data found")
                return
            }
            
            if let weatherResponse = self.parseJson(data: data) {
                print(weatherResponse.current)
                var temptOutput = "\(weatherResponse.current.temp_c)C"
                self.tempCelcius = "\(weatherResponse.current.temp_c)C"
                self.tempFaren = "\(weatherResponse.current.temp_f)F"
                DispatchQueue.main.async {
                    self.locationLabel.text = "\(weatherResponse.location.name), \(weatherResponse.location.country)"
                    if (!self.isCelcius.isOn) {
                        temptOutput = "\(weatherResponse.current.temp_f)F"
                    }
                    self.condition.text = weatherResponse.current.condition.text
                    self.temperatureLabel.text = temptOutput
                    self.checkImageCondition(code: weatherResponse.current.condition.code)
                }
            }
        }
        dataTask.resume()
    }
    
    private func checkImageCondition(code: Int) {
        let sfName: String

        switch code {
        case 1000:
            sfName = "cloud.sun.fill"
        case 1006:
            sfName = "cloud.circle.fill"
        case 1003:
            sfName = "cloud"
        case 1009:
            sfName = "smoke.fill"
        case 1195:
            sfName = "cloud.drizzle.fill"
        case 1183:
            sfName = "cloud.heavyrain.fill"
        case 1240:
            sfName = "cloud.rain.fill"
        case 1189:
            sfName = "cloud.rain.fill"
        case 1186:
            sfName = "cloud.rain.fill"
        case 1063:
            sfName = "cloud.rain.fill"
        default:
            sfName = "questionmark.circle"
        }
        let config = UIImage.SymbolConfiguration(paletteColors: [.systemBlue, .systemYellow, .systemGray])
        
        weatherConditionImage.preferredSymbolConfiguration = config
        weatherConditionImage.image = UIImage(systemName: sfName)
    }
    
    private func getURL(query: String) -> URL? {
        let baseUrl = "https://api.weatherapi.com/v1/"
        let currentEndpoint = "current.json"
        let apiKey = "475bfd0d481e44309fb01916240311"
        guard let url = "\(baseUrl)\(currentEndpoint)?key=\(apiKey)&q=\(query)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return nil
        }
        print(url)
        return URL(string: url)
    }
    
    private func parseJson(data: Data) -> WeatherResponse? {
        let decoder =  JSONDecoder()
        var weather: WeatherResponse?
        do {
            weather = try decoder.decode(WeatherResponse.self, from: data)
        } catch {
            print("Error decoding")
        }
        return weather
    }
}
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            locationLabel.text = "\(latitude), \(longitude)"
            loadWeather(search: locationLabel.text)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("errors")
    }
}

struct WeatherResponse: Decodable {
    let location: Location
    let current: Weather
}

struct Location: Decodable  {
    let name: String
    let country: String
}

struct Weather: Decodable  {
    let temp_c: Float
    let temp_f: Float
    let condition: WeatherCondition
}

struct WeatherCondition: Decodable  {
    let text: String
    let code: Int
}
