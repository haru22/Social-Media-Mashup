//
//  SocialMediaViewController.swift
//  SocialOne
//
//  Created by admin on 5/2/20.
//  Copyright © 2020 Benny Ooi. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import SwiftyJSON
import AlamofireImage
import FBSDKShareKit

class SocialMediaViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onFacebookLoginButton(_ sender: Any) {
        
        /*

         if let token = AccessToken.current,
             !token.isExpired {
             // User is logged in, do work such as go to next view controller.
         }
         */
        let loginManger = LoginManager()
        loginManger.logIn(permissions: ["public_profile", "user_posts"], from: self) { (result, error) in
            
            
            if let error = error {
              print("Failed to login: \(error.localizedDescription)")
              return
            }
            guard let accessToken = AccessToken.current
            else {
              print("Failed to get access token")
              return
                }
            
            print("Successful Login!")
            
            self.performSegue(withIdentifier: "toFeed", sender: nil)
            
            //self.getUserProfile()
            
        }
        
    }

    
       
           func getUserProfile()
           {
               

             //  Converted to Swift 5.1 by Swiftify v5.1.31847 - https://swiftify.com/
               if (AccessToken.current != nil) {
               GraphRequest(graphPath: "me", parameters:  ["fields": "id, name, about"]).start(completionHandler: { connection, result, error in

                     if error == nil {
                         if let result = result {
                             print("fetched user:\(result)")
                         }
                     }
                 })
             }
               
               
               

               
               let request = GraphRequest(graphPath: "/me/feed", parameters: ["fields":"full_picture, name" ], httpMethod: .get)
               request.start(completionHandler: { connection, result, error in
                   
                   if error == nil
                   {
                       
                       let json = JSON(result)
                       print("Json")
                       print(json["data"])
             

                   }
               
                   
               })

         
                   
               }

}
