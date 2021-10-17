//
//  Network.swift
//  TestTheFork
//
//  Created by VASILIJEVIC Sebastien on 15/10/2021.
//

import Foundation
import UIKit

class Network {
    static func getApi<Model: Decodable>(uri: String, completion: @escaping (Model?, Error?) -> ()) {
        guard let url = URL(string: uri) else {
            completion(nil, nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            
            DispatchQueue.main.async {
                if let data = data {
                    let jsonDecoder = JSONDecoder()
                    if let appDelegate = UIApplication.shared.delegate as? AppDelegate,
                       let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext {
                        jsonDecoder.userInfo[codingUserInfoKeyManagedObjectContext] = appDelegate.persistentContainer.viewContext
                    }
                    
                    do {
                        let data = try jsonDecoder.decode(Model.self, from: data)
                        
                        completion(data, nil)
                        
                    } catch let error {
                        print(error)
                        completion(nil, error)
                    }
                    
                } else if let error = error {
                    print(error)
                    completion(nil, error)
                }
            }
            
        }.resume()
    }
    
    static func getRestaurants(completion: @escaping (Restaurants?, Error?) -> ()) {
        self.getApi(uri: Constants.API.restaurants, completion: completion)
    }
}
