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
    
    @Published var location: CLLocationCoordinate2D?

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
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //Handle any errors here...
        print (error.localizedDescription)
    }
}
