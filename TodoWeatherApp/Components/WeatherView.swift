//
//  WeatherView.swift
//  TodoWeatherApp
//
//  Created by Marco Mascorro on 12/11/22.
//

import SwiftUI

struct WeatherView: View {
    @State var model: WeatherModel
    var body: some View {
        HStack {
            
            VStack(alignment: .leading, spacing: 0) {
                Image(model.conditionName)
                    .fixedSize()
                Text("\(Int(model.temperature))° F")
                    .font(.system(size: 36))
                    .foregroundColor(.white)
                
                
                
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text(model.cityName)
                    .foregroundColor(.white)
                    .fontWeight(.thin)
                    .padding(.bottom, 1)
                Text(model.description.capitalized)
                    .foregroundColor(.white)
                    .fontWeight(.thin)
            }
            
            
            
            
        }
        .padding(.horizontal)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(model: WeatherModel(conditionId: 1, cityName: "", temperature: 1.2, description: ""))
    }
}
