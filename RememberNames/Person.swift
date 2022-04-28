//
//  Person.swift
//  RememberNames
//
//  Created by Peter Hartnett on 4/27/22.
//

import Foundation
import UIKit
import CoreLocation

struct Person:  Identifiable, Comparable, Codable{
    static func < (lhs: Person, rhs: Person) -> Bool {
        lhs.name < rhs.name
    }
    
    func loadImage(url: URL) -> UIImage? {
        if let data = try? Data(contentsOf: url) {
            if let image = UIImage(data: data) {
                return image
            }
        }
        return nil
    }
    
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
   
    var id: UUID
    var name: String
   // var photo: UIImage?
    var photo: URL?
    
    init(){
        id = UUID()
        name = ""
        
        latitude = 0.0
        longitude = 0.0
    }
    
}
