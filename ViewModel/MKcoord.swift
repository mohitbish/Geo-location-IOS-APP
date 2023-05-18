//
//  coordViewModel.swift
//  A2M1
//
//  Created by Mohit Bishnoi on 20/5/2022.
//

import Foundation
import MapKit

extension MKCoordinateRegion: Equatable{
    
    public static func == (lhs: MKCoordinateRegion, rhs: MKCoordinateRegion) -> Bool {
        lhs.center.latitude  == rhs.center.latitude &&
        lhs.center.longitude == rhs.center.longitude &&
        lhs.span.latitudeDelta  == rhs.span.latitudeDelta &&
        lhs.span.longitudeDelta == rhs.span.longitudeDelta
    }
    
    var latitudeString: String{
        get{"\(center.latitude)"}
        set{
            guard let degrees  = CLLocationDegrees(newValue) else{return}
            center.latitude = degrees
        }
    }
    var longitudeString: String{
        get{"\(center.longitude)"}
        set{
            guard let degrees  = CLLocationDegrees(newValue) else{return}
            center.longitude = degrees
        }
    }
    
    
}
