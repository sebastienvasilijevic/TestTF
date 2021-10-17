//
//  WebServices.swift
//  TestTheFork
//
//  Created by VASILIJEVIC Sebastien on 15/10/2021.
//

import Foundation

class WebServices {
    static func loadRestaurants(completion: @escaping (Restaurants?, Bool?) -> Void) {
        Network.getRestaurants { restaurants, error in
            guard error == nil else {
                completion(nil, false)
                return
            }
            
            completion(restaurants, true)
        }
    }
}
