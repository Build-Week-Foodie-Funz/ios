//
//  LoginViewController.swift
//  FoodieFun
//
//  Created by William Chen on 9/23/19.
//  Copyright © 2019 William Chen. All rights reserved.
//

import UIKit

enum LoginType {
    case signUp
    case signIn
}

class LoginViewController: UIViewController {
    
    @IBOutlet weak var registerUsernameTextfield: UITextField!
    @IBOutlet weak var registerPasswordTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var locationTextfield: UITextField!
    @IBOutlet weak var usernameLoginTextfield: UITextField!
    @IBOutlet weak var passwordLoginTextfield: UITextField!
    
    var restaurantController: RestaurantController?
    var loginType = LoginType.signUp
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func registerButtonTapped(_ sender: Any) {
        guard let username = registerUsernameTextfield.text,
            let password = registerPasswordTextfield.text,
            let email = emailTextfield.text,
            let location = locationTextfield.text,
            !username.isEmpty,
            !password.isEmpty,
            !email.isEmpty,
            !location.isEmpty else { return }
        
        let user = User(userID: <#T##Int?#>, username: username, password: password, token: <#T##String?#>)
        
        if loginType == .signUp {
            restaurantController?.signUp(with: user, completion: { (networkError) in
                
                if let error = networkError {
                    NSLog("Error occurred during sign up: \(error)")
                } else {
                    let alert = UIAlertController(title: "Sign Up Successful", message: "Now please sign in", preferredStyle: .alert)
                    
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    
                    alert.addAction(okAction)
                }

            })
        }
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        guard let username = usernameLoginTextfield.text,
            let password = passwordLoginTextfield.text,
            !username.isEmpty,
            !password.isEmpty else { return }
        
        let user = User(userID: <#T##Int?#>, username: username, password: password, token: <#T##String?#>)
        
        if loginType == .signIn {
            restaurantController?.login(with: user, completion: { (networkError) in
                if let error = networkError {
                    NSLog("Error occurred during login: \(error)")
                } else {
                    DispatchQueue.main.async {
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            })
        }
        
        
        
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
