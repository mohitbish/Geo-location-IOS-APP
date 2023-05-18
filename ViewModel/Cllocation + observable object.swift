//
//  Cllocation + observable object.swift
//  A2M1
//
//  Created by Mohit Bishnoi on 5/6/2022.
//

import Foundation
import CoreLocation

class CoordViewModel: ObservableObject{
    @Published var coords: CLLocation
    @Published var sunriseSunset = SunriseSunset(sunrise: "unknown", sunset: "unknown")
    @Published var name = " "
    var sunrise: String{
        get{ sunriseSunset.sunrise}
        set{ sunriseSunset.sunrise = newValue}
    }
    var sunset: String{
        get{ sunriseSunset.sunset}
        set{ sunriseSunset.sunset = newValue}
    }
    
    init(coords: CLLocation){
        self.coords = coords
    }
    
    var latitudeString: String{
        get{"\(coords.coordinate.latitude)"}
        set{
            guard let newlatitude = Double(newValue)else {return}
            let newcoords =  CLLocation(latitude: newlatitude, longitude: coords.coordinate.longitude)
            coords = newcoords
        }
    }
    
    var longitudestring: String{
        get{"\(coords.coordinate.longitude)"}
        set{
            guard let newlongitude = Double(newValue)else {return}
            let newcoords =  CLLocation(latitude: coords.coordinate.longitude, longitude: newlongitude)
            coords = newcoords
        }
    }
    func lookupcoordinates(for place: String){
        let coder = CLGeocoder()
        coder.geocodeAddressString(place) {OptionalPlacemarks, optionalError in
            if let error = optionalError{
                print("Error lookin up\(place):\(error.localizedDescription)")
                return
            }
            guard let placemarks = OptionalPlacemarks, !placemarks.isEmpty else{
                print("placemarks empty")
                return
            }
            let placemark = placemarks[0]
            guard let coords = placemark.location else{
                print("placemark has no location")
                return
            }
            self.coords = coords
            
        }
    }
    
    func lookupName(for coords: CLLocation){
        let coder = CLGeocoder()
        coder.reverseGeocodeLocation(coords){OptionalPlacemarks, optionalError in
            if let error = optionalError{
                print("Error lookin up\(coords.coordinate):\(error.localizedDescription)")
                return
            }
            guard let placemarks = OptionalPlacemarks, !placemarks.isEmpty else{
                print("placemarks empty")
                return
            }
            let placemark = placemarks[0]
            self.name =  placemark.subAdministrativeArea ?? placemark.locality ??  placemark.subLocality ?? placemark.name ?? "Not Found"
        
        }
    }
    
    func lookupSunriseSunset(for place: String){
        let coder = CLGeocoder()
        coder.geocodeAddressString(place) {OptionalPlacemarks, optionalError in
            if let error = optionalError{
                print("Error lookin up\(place):\(error.localizedDescription)")
                return
            }
            guard let placemarks = OptionalPlacemarks, !placemarks.isEmpty else{
                print("placemarks empty")
                return
            }
            let placemark = placemarks[0]
            guard let coords = placemark.location else{
                print("placemark has no location")
                return
            }
            self.coords = coords
            
        }
        
        let urlstring = "https://api.sunrise-sunset.org/json?lat=\(latitudeString)&lng=\(longitudestring)"
        guard let url = URL(string: urlstring) else{
            print("Malformed URl:\(urlstring)")
            return
        }
        guard let jsonData = try? Data(contentsOf: url)else{
            print("could not load")
            return
        }
        guard let api = try? JSONDecoder().decode(SunriseSunsetAPI.self, from: jsonData)
            else {
            print("could not decode")
            return
            }
        let inputFormatter = DateFormatter()
        inputFormatter.dateStyle = .none
        inputFormatter.timeStyle = .medium
        inputFormatter.timeZone = .init(secondsFromGMT: 0)
        let outputFormatter = DateFormatter()
        outputFormatter.dateStyle = .none
        outputFormatter.timeStyle = .medium
        outputFormatter.timeZone = .current
        var converted = api.results
        if let time = inputFormatter.date(from: api.results.sunrise){
            converted.sunrise = outputFormatter.string(from: time)
        }
        if let time = inputFormatter.date(from: api.results.sunset){
            converted.sunset = outputFormatter.string(from: time)
        }
        sunriseSunset = converted
    }
}
