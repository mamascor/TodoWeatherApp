//
//  WeatherView.swift
//  TodoWeatherApp
//
//  Created by Marco Mascorro on 12/11/22.
//

import SwiftUI

struct WeatherView: View {
    var body: some View {
        HStack {
            
            VStack(alignment: .leading, spacing: 0) {
                Image("moon")
                    .fixedSize()
                Text("20° C")
                    .font(.system(size: 36))
                    .foregroundColor(.white)
                
                
                
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text("Dallas, TX")
                    .foregroundColor(.white)
                    .fontWeight(.thin)
                    .padding(.bottom, 1)
                Text("Dramatically Cloudy")
                    .foregroundColor(.white)
                    .fontWeight(.thin)
            }
            
            
            
            
        }
        .padding(.horizontal)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
