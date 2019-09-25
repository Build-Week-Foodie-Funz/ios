//
//  Foodie.swift
//  FoodieFun
//
//  Created by Steven Leyva on 9/24/19.
//  Copyright © 2019 William Chen. All rights reserved.
//

import Foundation
import UIKit

struct Restaurant: Codable {
    var name: String?
    var location: String?
    var hoursOfOperation: Int64?
    var overallRating: Int64?
    var reviews: [Review]?
    var photos: URL?
    
    enum CodingKeys: String, CodingKeys {
        case name = "restname"
    }
}


struct Review: Codable{
    let cuisineType: String?
    
    enum CodingKeys: String, CodingKeys {
        case cuisineType = "cuisinetype"
        case menuItem = "menuitemname"
        case photoMenu = "photomenu"
        case itemPrice = "itemprice"
        case itemRating = "itemrating"
        case review = "shortreview"
    }
}



