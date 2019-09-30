//
//  RegisterViewController.swift
//  FoodieFun
//
//  Created by Steven Leyva on 9/27/19.
//  Copyright © 2019 William Chen. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var locationTextfield: UITextField!
    
    var restaurantController: RestaurantController?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        
        
        guard let username = usernameTextfield.text,
            let password = passwordTextfield.text,
            let email = emailTextfield.text,
            let location = locationTextfield.text,
            !username.isEmpty,
            !password.isEmpty,
            !email.isEmpty,
            !location.isEmpty else { return }
        
         let idNumber = Int.random(in: 100...100000)
        
            
            restaurantController?.signUp(with: idNumber, username: username, password: password, email: email, completion: { (networkError) in
                
                if let error = networkError {
                    NSLog("Error occurred during sign up: \(error)")
                } else {
                    let alert = UIAlertController(title: "Sign Up Successful", message: "Now please sign in", preferredStyle: .alert)
                    
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    
                    alert.addAction(okAction)
                    
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "SignupSegue", sender: self)
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            })
   
    }
    @IBAction func cancelButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Navigation

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "SignupSegue" {
//            guard let detailVC = segue.destination as? LoginViewController else { return }
//            detailVC.restaurantController = restaurantController
//        }
//    }

}
