//
//  RestaurantData.swift
//  ProgrammaticCollection
//
//  Created by Emanuele Garolla on 22/11/2020.
//

import Foundation

struct RestaurantData: Decodable {
    var id: Int?
    var name: String?
    var gps_lat: Double?
    var gps_long: Double?
    var address: String?
    var city: String?
    var zipcode: String?
    var currency_code: String?
    var card_price: Int?
    var tripadvisor_avg_rate: Int?
    var tripadvisor_rate_count: Int?
    var avg_rate: Double?
    var rate_count: Int?
    var speciality: String?
    var url: String?
    var pics_diaporama: [String]?
    
    init?(fromData data: Data?) {
        let decoder = JSONDecoder()
        do {
            if let data = data {
                let decoded = try decoder.decode(RestaurantData.self, from: data)
                log("RestaurantData: Data decoded \(decoded)")
                self = decoded
            }
        } catch let decodingError {
            log("RestaurantData: Data error in decoding \(decodingError)")
            return nil
        }
    }
}

//JSON Example
//{
//    "id": 6861,
//    "name": "Katmandou Café",
//    "gps_lat": 48.857077900346,
//    "gps_long": 2.3725199699401855,
//    "address": "14, rue Bréguet",
//    "city": "Paris",
//    "zipcode": "75011",
//    "currency_code": "EUR",
//    "card_price": 27,
//    "tripadvisor_avg_rate": 4,
//    "tripadvisor_rate_count": 205,
//    "avg_rate": 9.2,
//    "rate_count": 5552,
//    "speciality": "Indian",
//    "url": "https://www.thefork.com/restaurant/katmandou-cafe-r6861",
//    "pics_diaporama": [
//        "https://res.cloudinary.com/tf-lab/image/upload/f_auto,q_auto,w_612,h_344/restaurant/4307d1f1-5ccd-448e-8172-d5ac97fc9a46/4c4a2dce-a987-422f-a226-e4b32d53c6c0.jpg",
//        "https://res.cloudinary.com/tf-lab/image/upload/f_auto,q_auto,w_612,h_344/restaurant/4307d1f1-5ccd-448e-8172-d5ac97fc9a46/35eea8a8-2694-44c9-b223-64e31be8010c.jpg",
//        "https://res.cloudinary.com/tf-lab/image/upload/f_auto,q_auto,w_612,h_344/restaurant/4307d1f1-5ccd-448e-8172-d5ac97fc9a46/1bcf36e0-7a31-4fb4-8a76-c592b0dfe6a9.jpg",
//        "https://res.cloudinary.com/tf-lab/image/upload/f_auto,q_auto,w_612,h_344/restaurant/4307d1f1-5ccd-448e-8172-d5ac97fc9a46/0d9ba4b0-7418-4d5f-9f22-a2d7edf1b3af.jpg",
//        "https://res.cloudinary.com/tf-lab/image/upload/f_auto,q_auto,w_612,h_344/restaurant/4307d1f1-5ccd-448e-8172-d5ac97fc9a46/5afc6776-0105-4383-8887-23a046f45cee.jpg",
//        "https://res.cloudinary.com/tf-lab/image/upload/f_auto,q_auto,w_612,h_344/restaurant/4307d1f1-5ccd-448e-8172-d5ac97fc9a46/1edbd414-9c24-4272-aeff-34de5e95cb3b.jpg"
//    ]
//}
