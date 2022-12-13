//
//  ContentView.swift
//  TodoWeatherApp
//
//  Created by Marco Mascorro on 12/11/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var locationmanager = LocationManager()
    @StateObject private var weathermanager = WeatherManager()
    
    var body: some View {
        ZStack {
            Color("grey").ignoresSafeArea()
            VStack {
                if let model = weathermanager.model {
                    WeatherView(model: model)
                }
                Spacer()
               
            }
           
        }
        .onAppear{
            locationmanager.requestLocation()
            DispatchQueue.main.async {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                    withAnimation(.linear) {
                        getWeatherData()
                    }
                   
                   print("Weather")
                }
               
            }
            
           
           
           
        }
        .navigationTitle("To Do")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Image(systemName: "plus")
            }
        }
        
       
    }
    
    func getWeatherData(){
        if let location = locationmanager.location {
            withAnimation {
                weathermanager.fetchWeather(location)
            }
           
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
