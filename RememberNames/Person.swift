//
//  Person.swift
//  RememberNames
//
//  Created by Peter Hartnett on 4/27/22.
//

import Foundation

struct Person: Codable, Identifiable{
    var id: UUID
    var name: String
    var photo: String
}
