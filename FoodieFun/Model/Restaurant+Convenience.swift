//
//  Restaurant+Convenience.swift
//  FoodieFun
//
//  Created by William Chen on 9/25/19.
//  Copyright © 2019 William Chen. All rights reserved.
//

import Foundation
import CoreData

extension Restaurant {

    convenience init(id: Int64, name: String, location: String, hoursOfOperation: Int64, overallRating: Int64, reviews: [Review], context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        self.init(context: context)
        self.id = id
        self.name = name
        self.location = location
        self.hoursOfOperation = hoursOfOperation
        self.overallRating = overallRating

        
    }
    
    @discardableResult convenience init?(restaurantRepresentation: RestaurantRepresentation, context: NSManagedObjectContext) {
        
        guard let id = restaurantRepresentation.id,
            let name = restaurantRepresentation.name,
            let location = restaurantRepresentation.location,
            let hoursOfOperation = restaurantRepresentation.hoursOfOperation,
            let overallRating = restaurantRepresentation.overallRating,
            let reviews = restaurantRepresentation.reviews
      
            else { return nil }
        
        self.init(id: id, name: name, location: location, hoursOfOperation: hoursOfOperation, overallRating: overallRating, reviews: reviews)
    }
    
    var restaurantRepresentation: RestaurantRepresentation? {
        guard let reviews = reviews else {return nil}
        let reviewArray = Array(reviews)
        
        return RestaurantRepresentation(id: id, name: name, location: location, hoursOfOperation: hoursOfOperation, overallRating: overallRating, reviews: reviewArray as? [Review])//(id: id, name: name, location: location, hoursOfOperation: hoursOfOperation, overallRating: overallRating, reviews: /*reviewArray as? [Review]*/)
    }
    
}


extension ReviewEntity {
    convenience init (reviewId: Int64, cuisineType: String, menuItem: String, photoMenu: String, itemPrice: Int64, itemRating: String, review: String, context: NSManagedObjectContext){
        
        self.init(context: context)
        self.reviewId = reviewId
        self.cuisineType = cuisineType
        self.menuItem = menuItem
        self.itemRating = itemRating
        self.itemPrice = itemPrice
        self.photoMenu = photoMenu
        
        
        
    }
    
    convenience init(cuisineType: String, review: String, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.cuisineType = cuisineType
        self.review = review
    }
}
