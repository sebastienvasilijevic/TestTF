//
//  Restaurant.swift
//  TestTheFork
//
//  Created by VASILIJEVIC Sebastien on 15/10/2021.
//

import CoreData
import Foundation


// MARK: - Restaurants
struct Restaurants: Codable {
    let data: [Restaurant]
}

// MARK: - Restaurant
struct Restaurant: Codable {
    var uuid: String
    let name, servesCuisine, currenciesAccepted: String?
    let priceRange: Int?
    let address: Address?
    let aggregateRatings: AggregateRatings?
    let mainPhoto: MainPhoto?
}

// MARK: - Address
struct Address: Codable {
    let street, postalCode, locality: String?
    
    public func fullAddress() -> String {
        return String(format: "%@, %@ %@", street ?? "", postalCode ?? "", locality ?? "")
    }
}

// MARK: - AggregateRatings
struct AggregateRatings: Codable {
    let thefork, tripadvisor: Rating?
    
    public func getTheForkRating() -> String? {
        if thefork == nil {
            return nil
        }
        return "\(thefork!.ratingValue) / 10 (\(thefork!.reviewCount))"
    }
    
    public func getTripAdvisorkRating() -> String? {
        if tripadvisor == nil {
            return nil
        }
        return "\(tripadvisor!.ratingValue) / 5 (\(tripadvisor!.reviewCount))"
    }
}

// MARK: - Rating
struct Rating: Codable {
    let ratingValue: Double
    let reviewCount: Int
}

// MARK: - MainPhoto
struct MainPhoto: Codable {
    let uri: String?

    enum CodingKeys: String, CodingKey {
        case uri = "480x270"
    }
}
