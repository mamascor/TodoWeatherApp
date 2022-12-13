//
//  LocationManager.swift
//  TodoWeatherApp
//
//  Created by Marco Mascorro on 12/12/22.
//

import Foundation
import CoreLocation
import MapKit

final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    
    @Published var model: WeatherModel?
    
    @Published var location: CLLocationCoordinate2D? {
        didSet {
            guard let location = location else { fatalError("❌ DEBUG: Location couldnt load") }
            
            fetchWeather(location)
        }
    }
    
    let url = "https://api.openweathermap.org/data/2.5/weather?appid=31b928bbacb19b6fa37259041d320a32&units=imperial"

    override init() {
        super.init()
        locationManager.delegate = self
    }

    func requestLocation() {
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        DispatchQueue.main.async {
            self.location = location.coordinate
            
           
            
            print("📍 DEBUG: Location")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //Handle any errors here...
        print ("DEBUG 2: ",error.localizedDescription)
    }
}


extension LocationManager {
    
    func fetchWeather(_ coordinate: CLLocationCoordinate2D) {
        let url = "\(url)&lat=\(coordinate.latitude)&lon=\(coordinate.longitude)"
        
        print("❌ DEBUG: Fetched URL: \(url)")
        
        performRequest(with: url)
    }
    
    func performRequest(with url: String){
        guard let urlString = URL(string: url) else { return }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: urlString) { data, response, error in
            if let error = error {
                print("DEBUG 1",error.localizedDescription)
            }
            
            guard let fetchedData = data else { return }
            
            if let weather = self.parseJson(fetchedData) {
                DispatchQueue.main.async {
                    self.model = weather
                }

            }
            
            
            
        }
        task.resume()
    }
    
    
    func parseJson(_ data: Data) -> WeatherModel? {
        let jd = JSONDecoder()
        
        do {
            let decodedData = try jd.decode(WeatherData.self, from: data)
            let id = decodedData.weather[0].id
            let description = decodedData.weather[0].description
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp, description: description)
            
            print(weather)
            
            
            return weather
            
        } catch {
            print("DEBUG: Could not decoded data.")
            
            return nil
        }
        
    }
}
