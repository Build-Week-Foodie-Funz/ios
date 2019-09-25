//
//  Restaurant+Convenience.swift
//  FoodieFun
//
//  Created by William Chen on 9/25/19.
//  Copyright © 2019 William Chen. All rights reserved.
//

import Foundation
import CoreData

extension Restaurant{
    @discardableResult convenience init(name: String, location: String, hoursOfOperation: Int64, overallRating: Int64, photos: URL, reviews: String, context: NSManagedObjectContext = CoreDataStack.shared.mainContext){
        
        self.init(context: context)
        self.name = name
        self.location = location
        self.hoursOfOperation = hoursOfOperation
        self.overallRating = overallRating
        self.photos = photos
        self.reviews = reviews
        
    }
    
}
