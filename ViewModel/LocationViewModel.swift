//
//  LocationViewModel.swift
//  A2M1
//
//  Created by Mohit Bishnoi on 12/5/2022.
//

import Foundation
import CoreData
import SwiftUI

fileprivate  let defaultImage = Image(systemName: "photo")
fileprivate var downloadedImages = [URL : Image]()

extension Location{
    
    var locationname: String {
        get{name ?? "" }
        set{
            name = newValue
            save()
        }
    }
    
    var Detail: String {
        get{detail ?? "" }
        set{
            detail = newValue
            save()
        }
    }
    
    var Latitude: String{
        get{ String(latitude) }
        set{
            guard let Latitude = Double(newValue) else { return  }
            latitude = Latitude
            save()
        }
    }
    
    var Longitude: String{
        get{ String(longitude) }
        set{
            guard let Longitude = Double(newValue) else { return  }
            longitude = Longitude
            save()
        }
    }
    
    var urlString : String{
        get{ imageURL?.absoluteString ?? ""}
        set{
            guard let url = URL(string: newValue)else{return}
            imageURL = url
            save()
        }
    }
    
    func getImage() async -> Image {
        guard let url = imageURL else { return defaultImage }
        if let image = downloadedImages[url] { return image }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            print("Downloaded \(response.expectedContentLength) bytes.")
            guard let uiImg = UIImage(data: data) else { return defaultImage }
            let image = Image(uiImage: uiImg).resizable()
            downloadedImages[url] = image
            return image
        } catch {
            print("Error downloading \(url): \(error.localizedDescription)")
        }
        return defaultImage
    }
    
    @discardableResult
    func save() -> Bool{
        do{
            try managedObjectContext?.save()
        }
        catch{
            print("Error Saving:\(error)")
            return false
        }
        return true
    }
}
