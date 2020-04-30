//
//  ViewController.swift
//  SocialOne
//
//  Created by Benny Ooi Kean Hoe on 4/18/20.
//  Copyright © 2020 Benny Ooi. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func signInOnClick(_ sender: Any) {
        if let username = usernameTextField.text, let password = passwordTextField.text {
            PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
                if let err = error {
                    print(err.localizedDescription)
                } else {
                    if user != nil {
                        self.performSegue(withIdentifier: "LoginSegue", sender: nil)
                    }
                }
            }
        }
    }
    

}

