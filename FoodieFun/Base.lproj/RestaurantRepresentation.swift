//
//  Foodie.swift
//  FoodieFun
//
//  Created by Steven Leyva on 9/24/19.
//  Copyright © 2019 William Chen. All rights reserved.
//

import Foundation
import UIKit

struct RestaurantRepresentation: Codable {
    
    var name: String?
    var location: String?
    var hoursOfOperation: Int64?
    var overallRating: Int64?
    var reviews: [Review]?
    var photos: URL?
    
    enum CodingKeys: String, CodingKey {
        case name = "restname"
    }
}

struct Review: Equatable, Codable {
    var cuisineType: String?
    var menuItem: String?
    var photoMenu: String?
    var itemPrice: Int?
    var itemRating: String?
    var review: String?
    
    enum CodingKeys: String, CodingKey {
        case cuisineType = "cuisinetype"
        case menuItem = "menuitemname"
        case photoMenu = "photomenu"
        case itemPrice = "itemprice"
        case itemRating = "itemrating"
        case review = "shortreview"
    }
}



