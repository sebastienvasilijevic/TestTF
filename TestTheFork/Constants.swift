//
//  Constants.swift
//  TestTheFork
//
//  Created by VASILIJEVIC Sebastien on 15/10/2021.
//

import UIKit

// MARK: - Constants
struct Constants {
    
    static let margins: CGFloat = 8.0
    
    // MARK: - API
    struct API {
        static let restaurants = "https://alanflament.github.io/TFTest/test.json"
    }
    
    // MARK: - Images
    struct Images {
        // MARK: - Assets
        static let cash = "cash"
        static let solidHeart = "solid-heart"
        static let filledHeart = "filled-heart"
        static let food = "food"
        static let location = "location"
        static let noPicture = "no_picture"
        static let sort = "sort"
        static let taBubblesEmpty = "ta-bubbles-empty"
        static let taBubblesHalf = "ta-bubbles-half"
        static let taBubblesFull = "ta-bubbles-full"
        static let taLogo = "ta-logo"
        static let tfLogo = "tf-logo"
    }
    
    // MARK: - Colors
    struct Colors {
        static let mainGreen = UIColor(named: "main-green")!
    }
}
