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
    var typeOfCuisine: String?
    var location: String?
    var hoursOfOperation: UInt
    var overallRating: UInt?
    var reviews: String?
    var photos: UIImage?
}
