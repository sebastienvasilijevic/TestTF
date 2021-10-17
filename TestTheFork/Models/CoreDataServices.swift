//
//  CoreDataServices.swift
//  TestTheFork
//
//  Created by VASILIJEVIC Sebastien on 16/10/2021.
//

import CoreData
import UIKit

class CoreDataServices {
    static var persistentContainer: NSPersistentContainer? {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        return delegate.persistentContainer
    }
    
    static func toggleFavoriteRestaurant(for restaurant: Restaurant?) {
        if CoreDataServices.isRestaurantExists(for: restaurant) {
            CoreDataServices.deleteFavoriteRestaurant(for: restaurant)
            
        } else {
            CoreDataServices.addFavoriteRestaurant(for: restaurant)
        }
    }
    
    static func addFavoriteRestaurant(for restaurant: Restaurant?) {
        guard let restaurant = restaurant,
              let persistentContainer = CoreDataServices.persistentContainer else {
            return
        }
        let context = persistentContainer.viewContext
        
        let newRestaurant = FavoriteRestaurant(context: context)
        newRestaurant.uuid = restaurant.uuid
        
        try? context.save()
    }
    
    static func deleteFavoriteRestaurant(for restaurant: Restaurant?) {
        guard let restaurant = restaurant,
              let persistentContainer = CoreDataServices.persistentContainer else {
            return
        }
        let context = persistentContainer.viewContext
        
        if let favoriteRestaurant = CoreDataServices.getFavoriteRestaurant(for: restaurant) {
            context.delete(favoriteRestaurant)
        }
    }
    
    static func isRestaurantExists(for restaurant: Restaurant?) -> Bool {
        return CoreDataServices.getFavoriteRestaurant(for: restaurant) != nil
    }
    
    static func getFavoriteRestaurant(for restaurant: Restaurant?) -> FavoriteRestaurant? {
        guard let restaurant = restaurant,
              let persistentContainer = CoreDataServices.persistentContainer else {
            return nil
        }
        
        let context = persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<FavoriteRestaurant> = FavoriteRestaurant.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(
            format: "uuid LIKE %@", restaurant.uuid
        )
        
        let objects = try? context.fetch(fetchRequest)
        
        return (objects != nil && objects!.count > 0) ? objects!.first : nil
    }
}
