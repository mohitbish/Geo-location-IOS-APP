//
//  sunriseSunset.swift
//  A2M1
//
//  Created by Mohit Bishnoi on 5/6/2022.
//

import Foundation

struct SunriseSunset: Codable{
    var sunrise: String
    var sunset: String
}

struct SunriseSunsetAPI: Codable{
    var results: SunriseSunset
    var status: String?
}
