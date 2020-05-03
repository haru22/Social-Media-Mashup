//
//  FacebookCollectionViewCell.swift
//  SocialOne
//
//  Created by Benny Ooi Kean Hoe on 4/25/20.
//  Copyright © 2020 Benny Ooi. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit

class FacebookCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var numFriendLabel: UILabel!
    @IBOutlet weak var photosLabel: UILabel!
    @IBOutlet weak var numPhotosLabel: UILabel!
    @IBOutlet weak var friendsLabel: UILabel!
    
    

    
    @IBAction func signOutButtonOnClick(_ sender: UIButton) {
    }
    
    @IBAction func loginButtonOnClick(_ sender: UIButton) {

            /*

             if let token = AccessToken.current,
                 !token.isExpired {
                 // User is logged in, do work such as go to next view controller.
             }
             */
            
        
    }
}
