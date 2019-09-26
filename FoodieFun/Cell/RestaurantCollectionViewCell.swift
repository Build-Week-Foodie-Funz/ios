//
//  RestaurantCollectionViewCell.swift
//  FoodieFun
//
//  Created by Steven Leyva on 9/25/19.
//  Copyright © 2019 William Chen. All rights reserved.
//

import UIKit

class RestaurantCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var restaurantImageView: UIView!
    @IBOutlet weak var infoLabel: UILabel!
    
    var restaurant: Restaurant? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let restaurant = restaurant else { return }
        // setup labela nd image here.
    }
}
