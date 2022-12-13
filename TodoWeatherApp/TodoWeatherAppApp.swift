//
//  TodoWeatherAppApp.swift
//  TodoWeatherApp
//
//  Created by Marco Mascorro on 12/11/22.
//

import SwiftUI

@main
struct TodoWeatherAppApp: App {
    
    let persistenceController = PersistenceController.shared
    @EnvironmentObject var locationmanager: LocationManager
    
    var body: some Scene {
        WindowGroup {
            AppTabView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environment(\.colorScheme, .dark)
        }
    }
}
