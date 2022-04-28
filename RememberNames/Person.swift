//
//  Person.swift
//  RememberNames
//
//  Created by Peter Hartnett on 4/27/22.
//

import Foundation
import UIKit

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
    
    
    
    var id: UUID
    var name: String
   // var photo: UIImage?
    var photo: URL?
    
    init(){
        id = UUID()
        name = ""
        //photo = ""
    }
    
}
