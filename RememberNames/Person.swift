//
//  Person.swift
//  RememberNames
//
//  Created by Peter Hartnett on 4/27/22.
//

import Foundation
import UIKit

struct Person:  Identifiable{
    var id: UUID
    var name: String
    var photo: UIImage?
    
    init(){
        id = UUID()
        name = ""
        
    }
}
