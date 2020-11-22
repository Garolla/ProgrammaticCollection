//
//  RestaurantManager.swift
//  ProgrammaticCollection
//
//  Created by Emanuele Garolla on 22/11/2020.
//

import Foundation

let restaurantManager = RestaurantManager.shared

class RestaurantManager {
    private init() {}
    static let shared = RestaurantManager()
    
    private let url = URL(string: "https://ptitchevreuil.github.io/test.json")
}
