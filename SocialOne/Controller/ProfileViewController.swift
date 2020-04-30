//
//  ProfileViewController.swift
//  SocialOne
//
//  Created by Benny Ooi Kean Hoe on 4/25/20.
//  Copyright © 2020 Benny Ooi. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func logoutOnClick(_ sender: UIBarButtonItem) {
        PFUser.logOut()
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(identifier: "LoginViewController")
        let delegate = self.view.window?.windowScene?.delegate as! SceneDelegate
        delegate.window?.rootViewController = loginViewController
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
 
        if indexPath.row == 0 {
            //Instagram Cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InstagramCollectionCell", for: indexPath) as! InstagramCollectionViewCell
            
            //Not log in
            cell.numPostLabel.text = ""
            cell.numFollowerLabel.text = ""
            cell.numFollowingLabel.text = ""
            cell.postLabel.isHidden = true
            cell.followingLabel.isHidden = true
            cell.followersLabel.isHidden = true
            cell.profileImageView.isHidden = true
            cell.loginInstagramButton.isHidden = false
            cell.signOutInstagramButton.isEnabled = false
            cell.nameLabel.text = ""
            
            
            cell.contentView.layer.cornerRadius = 4.0
            cell.contentView.layer.borderWidth = 1.0
            cell.contentView.layer.borderColor = UIColor.clear.cgColor
            cell.contentView.layer.masksToBounds = false
            cell.layer.shadowColor = UIColor.gray.cgColor
            cell.layer.shadowOffset = CGSize(width: 0, height: 1.0)
            cell.layer.shadowRadius = 4.0
            cell.layer.shadowOpacity = 1.0
            cell.layer.masksToBounds = false
            cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
            return cell
        } else if indexPath.row == 1 {
            //Facebook Cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FacebookCollectionCell", for: indexPath) as! FacebookCollectionViewCell
            
            //Not log in
            cell.numFriendLabel.text = ""
            cell.nameLabel.text = ""
            cell.friendsLabel.isHidden = true
            cell.loginButton.isHidden = false
            cell.numPhotosLabel.text = ""
            cell.photosLabel.isHidden = true
            cell.signOutButton.isEnabled = false
            cell.userImageView.isHidden = true
            
            cell.contentView.layer.cornerRadius = 4.0
            cell.contentView.layer.borderWidth = 1.0
            cell.contentView.layer.borderColor = UIColor.clear.cgColor
            cell.contentView.layer.masksToBounds = false
            cell.layer.shadowColor = UIColor.gray.cgColor
            cell.layer.shadowOffset = CGSize(width: 0, height: 1.0)
            cell.layer.shadowRadius = 4.0
            cell.layer.shadowOpacity = 1.0
            cell.layer.masksToBounds = false
            cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
            return cell
        } else {
            //Twitter Cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TwitterCollectionCell", for: indexPath) as! TwitterCollectionViewCell
            if UserDefaults.standard.bool(forKey: "twitterUserLoggedIn") {
                cell.followersLabel.isHidden = false
                cell.followingLabel.isHidden = false
                cell.loginTwitterButton.isHidden = true
                cell.profileImageView.isHidden = false
                cell.signoutTwitterButton.isEnabled = true
                cell.tweetsLabel.isHidden = false
                
               
                
                cell.nameLabel.text = ""
                cell.numFollowersLabel.text = ""
                cell.numFollowingLabel.text = ""
                cell.numTweetsLabel.text = ""
            } else {
                //Not logged in
                cell.followersLabel.isHidden = true
                cell.followingLabel.isHidden = true
                cell.loginTwitterButton.isHidden = false
                cell.nameLabel.text = ""
                cell.numFollowersLabel.text = ""
                cell.numFollowingLabel.text = ""
                cell.numTweetsLabel.text = ""
                cell.profileImageView.isHidden = true
                cell.signoutTwitterButton.isEnabled = false
                cell.tweetsLabel.isHidden = true
            }
            
            cell.contentView.layer.cornerRadius = 4.0
            cell.contentView.layer.borderWidth = 1.0
            cell.contentView.layer.borderColor = UIColor.clear.cgColor
            cell.contentView.layer.masksToBounds = false
            cell.layer.shadowColor = UIColor.gray.cgColor
            cell.layer.shadowOffset = CGSize(width: 0, height: 1.0)
            cell.layer.shadowRadius = 4.0
            cell.layer.shadowOpacity = 1.0
            cell.layer.masksToBounds = false
            cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
            return cell
        }
    }
}
