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
    var hoursOfOperation: UInt
    var overallRating: UInt?
    var reviews: Review?
    var photos: UIImage?
}


struct Review: Codable{
    let cuisineType: String?
    
    enum CodingKeys: String, CodingKey {
        case cuisineType = "cuisinetype"
        case menuItem = "menuitemname"
        case photoMenu = "photomenu"
        case itemPrice = "itemprice"
        case itemRating = "itemrating"
        case review = "shortreview"
    }
}
