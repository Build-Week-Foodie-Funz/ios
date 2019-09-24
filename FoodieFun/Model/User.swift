//
//  User.swift
//  FoodieFun
//
//  Created by William Chen on 9/24/19.
//  Copyright © 2019 William Chen. All rights reserved.
//

import Foundation
import UIKit

struct User: Codable, Equatable {
    let id: Int?
    let name: String?
    var typeOfCuisine: String?
    var location: String?
    var hoursOfOperation: UInt?
    var overallRating: UInt?
    var reviews: String?
    var photos: UIImage?
    let token: String?
}

