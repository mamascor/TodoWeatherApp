//
//  TabView.swift
//  TodoWeatherApp
//
//  Created by Marco Mascorro on 12/11/22.
//

import SwiftUI

struct AppTabView: View {
    var body: some View {
        TabView {
            
            NavigationView {
                ContentView()
                   
                   
            }
            .foregroundColor(.white)
        }
        .accentColor(.white)
    }
}

struct AppTabView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView()
    }
}
