//
//  RegisterViewController.swift
//  SocialOne
//
//  Created by Benny Ooi Kean Hoe on 4/25/20.
//  Copyright © 2020 Benny Ooi. All rights reserved.
//

import UIKit
import Parse

class RegisterViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func cancelOnClick(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func registerOnClick(_ sender: UIButton) {
        let user = PFUser()
        if let username = usernameTextField.text, let password = passwordTextField.text, let name = nameTextField.text {
            user.username = username
            user.password = password
            user["name"] = name
            
            user.signUpInBackground { (success, error) in
                if success {
                    self.performSegue(withIdentifier: "RegisterSegue", sender: nil)
                } else {
                    if let err = error {
                        print(err.localizedDescription)
                    }
                }
            }
        }
        
    }
}
