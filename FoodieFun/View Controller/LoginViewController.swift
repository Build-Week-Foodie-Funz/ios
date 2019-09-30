//
//  LoginViewController.swift
//  FoodieFun
//
//  Created by William Chen on 9/23/19.
//  Copyright © 2019 William Chen. All rights reserved.
//

import UIKit

enum LoginType2 {
    case signIn
}

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameLoginTextfield: UITextField!
    @IBOutlet weak var passwordLoginTextfield: UITextField!
    
    var restaurantController = RestaurantController()
    var loginType: LoginType2?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        guard let username = usernameLoginTextfield.text,
            let password = passwordLoginTextfield.text,
            !username.isEmpty,
            !password.isEmpty else { return }
        
        let idNumber = Int.random(in: 100...100000)
        
        if loginType == .signIn {
            restaurantController.login(with: username, password: password, completion: { (networkingError) in
                if let error = networkingError {
                    NSLog("Error occurred during login: \(error)")
                } else {
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "LoginSegue", sender: self)
                    }
                }
            })
        }

    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LoginSegue" {
            guard let detailVC = segue.destination as? RestaurantCollectionViewController else { return }
            detailVC.restuarantController = restaurantController
        }else if segue.identifier == "registerSegue" {
            guard let registerVC = segue.destination as? RegisterViewController else {return}
            registerVC.restaurantController = restaurantController
        }
    }
    
    
}
