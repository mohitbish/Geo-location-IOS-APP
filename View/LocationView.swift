//
//  LocationView.swift
//  A2M1
//
//  Created by Mohit Bishnoi on 12/5/2022.
//

import SwiftUI
import MapKit
import CoreLocation


struct LocationView: View {
    @Environment(\.editMode) var editMode
    @ObservedObject var location: Location
    @State var image = Image(systemName: "photo")
    @ObservedObject var coords: CoordViewModel
    
    var body: some View {
        List{
            if editMode?.wrappedValue == .active{
                TextField("Enter Name", text: $location.locationname)
                TextField("Enter ImageURL", text: $location.urlString)
                TextField("Enter detail", text: $location.Detail)
            }else{
                Text(location.locationname)
                image.aspectRatio(contentMode: .fit)
                VStack {
                    Text("Details")
                    Text("\(location.Detail)")
                }
                NavigationLink {
                    MapView(location: location, coords: coords)
                }label: {
                   Label("Map", systemImage: "map")
                }
                HStack {
                    Label(coords.sunrise, systemImage:"sunrise")
                    Spacer()
                    Label(coords.sunset, systemImage: "sunset")
                }.padding()
            }
        }
        .navigationTitle(location.locationname)
        .task {
            image = await location.getImage()
            if( location.name != "New Location"){
                coords.lookupSunriseSunset(for: location.locationname)
            }
        }
    }
    
    
    
}

