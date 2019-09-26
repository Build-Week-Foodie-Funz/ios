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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
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
