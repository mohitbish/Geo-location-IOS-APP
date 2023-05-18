//
//  MapView.swift
//  A2M1
//
//  Created by Mohit Bishnoi on 20/5/2022.
//

import SwiftUI
import MapKit
import CoreData
import CoreLocation

struct MapView: View {
    @ObservedObject var location: Location
    @ObservedObject var coords: CoordViewModel
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -27.5, longitude: 153),
                                           span: MKCoordinateSpan(latitudeDelta: 0.75, longitudeDelta: 0.75))
    
    

    var body: some View {
            VStack {
                HStack {
                    HStack{
                        Button{
                            withAnimation{
                                coords.lookupName(for: CLLocation(latitude: region.center.latitude, longitude:region.center.longitude))
                            }
                        } label:{
                            Label("Name:", systemImage: "text.magnifyingglass")
                        }
                        TextField("Location name", text: $coords.name ){
                            
                            coords.lookupcoordinates(for: coords.name)
                        }
                    }
                    HStack{
                        Button{
                            withAnimation{
                                region.span = MKCoordinateSpan(latitudeDelta: 0.125 , longitudeDelta: 0.125)
                            }
                        } label:{
                            Label("", systemImage: "plus")
                        }
                        Button{
                            withAnimation{
                                region.span = MKCoordinateSpan(latitudeDelta: 0.75 , longitudeDelta: 0.75)
                            }
                        } label:{
                            Label("", systemImage: "minus")
                        }
                    }
                }
                Map(coordinateRegion: $region)
                HStack{
                    Button{
                        region.center = coords.coords.coordinate
                    } label:{
                        Label("", systemImage: "globe")
                    }
                    HStack {
                        Text("lat:")
                        TextField("Enter LAtitude", text: $region.latitudeString)
                    }
                    HStack {
                        Text("lon:")
                        TextField("Enter Longitude", text: $region.longitudeString)
                    }
                }
            }
    }
}






