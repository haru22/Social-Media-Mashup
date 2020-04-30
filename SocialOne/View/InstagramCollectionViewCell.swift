//
//  InstagramCollectionViewCell.swift
//  SocialOne
//
//  Created by Benny Ooi Kean Hoe on 4/25/20.
//  Copyright © 2020 Benny Ooi. All rights reserved.
//

import UIKit

class InstagramCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var signOutInstagramButton: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var loginInstagramButton: UIButton!
    @IBOutlet weak var numPostLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var numFollowerLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var numFollowingLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    
    
    
    
    @IBAction func loginButtonOnClick(_ sender: UIButton) {
    }
    
    
    @IBAction func signOutButtonOnClick(_ sender: UIButton) {
    }
    
}
