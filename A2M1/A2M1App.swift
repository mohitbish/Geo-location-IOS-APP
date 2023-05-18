//
//  A2M1App.swift
//  A2M1
//
//  Created by Mohit Bishnoi on 12/5/2022.
//

import SwiftUI
import CoreLocation

@main
struct A2M1App: App {
    let persistenceController = PersistenceController.shared
    @StateObject var coordinates = CoordViewModel(coords: CLLocation(latitude: -27.47, longitude: 153.02))
   
    var body: some Scene {
        WindowGroup {
            ContentView(coords: coordinates)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
