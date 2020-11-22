//
//  RestaurantManager.swift
//  ProgrammaticCollection
//
//  Created by Emanuele Garolla on 22/11/2020.
//

import UIKit

let restaurantManager = RestaurantManager.shared

class RestaurantManager {
    private init() {}
    static let shared = RestaurantManager()
    
    private let url = URL(string: "https://ptitchevreuil.github.io/test.json")
    
    func getRestaurant(completion: @escaping (RestaurantData?, Error?) -> ()) {
        if let url = url {
            let downloadSession = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
            
            downloadSession.dataTask(with: url,
                                     completionHandler: { data, response, error in
                                        log("RestaurantManager: data \(String(describing: data)), response : \(String(describing: response)), error \(String(describing: error))")
                                        completion(RestaurantData(fromData: data), error)
            }).resume()
        }
    }
    
    func getRestaurantImage(imageURL: URL?, completion: @escaping (UIImage?, Error?) -> ()) {
        if let url = imageURL {
            let downloadSession = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
            
            downloadSession.dataTask(with: url,
                                     completionHandler: { data, response, error in
                                        log("RestaurantManager: data \(String(describing: data)), response : \(String(describing: response)), error \(String(describing: error))")
                                        var image: UIImage?
                                        if let data = data {
                                            image = UIImage(data: data)
                                        }
                                        completion(image, error)
            }).resume()
        }
    }
}
