//
//  ContentView.swift
//  TodoWeatherApp
//
//  Created by Marco Mascorro on 12/11/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color("grey").ignoresSafeArea()
            VStack {
                WeatherView()
                
                Spacer()
               
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
