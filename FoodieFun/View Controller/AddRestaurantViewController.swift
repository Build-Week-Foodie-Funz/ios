//
//  AddRestaurantViewController.swift
//  FoodieFun
//
//  Created by William Chen on 9/23/19.
//  Copyright © 2019 William Chen. All rights reserved.
//

import UIKit

class AddRestaurantViewController: UIViewController {

    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var idTexfield: UITextField!
    @IBOutlet weak var cusineTypeTextfield: UITextField!
    @IBOutlet weak var locationTextfield: UITextField!
    @IBOutlet weak var operationHoursTexfield: UITextField!
    @IBOutlet weak var ratingTextfield: UITextField!
    @IBOutlet weak var reviewTextfield: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    
    var restaurantController: RestaurantController?
    var restaurantRepresentation: RestaurantRepresentation?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
 
    @IBAction func saveButton(_ sender: UIButton) {
        saveButton.isEnabled = false
    }
    
    func createRestaurant(){
        guard let name = nameTextfield.text,
            let restaurant = restaurantRepresentation,
            let id = idTexfield.text,
            let newIdentity = Int64(id),
            let cuisine = cusineTypeTextfield.text,
            let location = locationTextfield.text,
            let hours = operationHoursTexfield.text,
            let Inthours = Int64(hours),
            let rating = ratingTextfield.text,
            let newRating = Int64(rating)
            else {
                DispatchQueue.main.async {
                self.saveButton.isEnabled = true
                }
                return
            }
        
    
        

        
        guard let review = reviewTextfield.text else {return}
            let reviews = Review(cuisineType: cuisine, review: review)
        
        
        restaurantController?.createRestaurant(with: newIdentity, restaurant: restaurant, name: name, location: location, reviews: [reviews] , hoursOfOperation: Inthours, overallRating: newRating)
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
