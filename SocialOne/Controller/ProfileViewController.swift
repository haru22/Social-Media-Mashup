//
//  ProfileViewController.swift
//  SocialOne
//
//  Created by Benny Ooi Kean Hoe on 4/25/20.
//  Copyright © 2020 Benny Ooi. All rights reserved.
//

import UIKit
import Parse
import FBSDKLoginKit
import FBSDKCoreKit
import SwiftyJSON

class ProfileViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var facebookProfileImage: UIImageView!
    
    @IBOutlet weak var facebookFriendsCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadFacebookProfileInfo()
        

        // Do any additional setup after loading the view.
    }
    



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
    
    @IBAction func onFacebookLoginButton(_ sender: Any) {
        
        
        
        /*
          if let token = AccessToken.current,
              !token.isExpired {
              // User is logged in, do work such as go to next view controller.
          }*/
        
          
         let loginManger = LoginManager()
         loginManger.logIn(permissions: ["public_profile", "user_posts", "user_friends"], from: self) { (result, error) in
             
             
             if let error = error {
               print("Failed to login: \(error.localizedDescription)")
               return
             }
        
             else
             {
                print("Successful Login!")
                self.loadFacebookProfileInfo()
                return
             }
             
          
             
          
        }
    }
    
    
    @IBAction func onTwitterLoginButton(_ sender: Any) {
        
        print("on twitter login")
        let myUrl = "https://api.twitter.com/oauth/request_token"
        
        TwitterAPICaller.client?.login(url: myUrl, success: {
            
            print("log in sucessfully to twitter")
            self.performSegue(withIdentifier: "backFromTwitter", sender: self)
        }, failure: { (Error) in
            print("falide to sign in to twitter\n]=\(Error.localizedDescription)")
        })
        
    }
    
    
    func loadFacebookProfileInfo()
    {
        print("Loading facebook profile info")
        var userId: String = ""
        var userFriendCount: String = "0"
        
        if (AccessToken.current != nil)
        {
            GraphRequest(graphPath: "me", parameters:  ["fields": "id"]).start(completionHandler: { connection, result, error in
                if error == nil
                {
                        if let result = result {
                            print("fetched user:\(result)")
                            userId = JSON(result)["id"].string!
                            print("User Id: \(userId)")
                        }
                }
            
                if userId != ""
                {
                    print("Loading profile image")
                    let profilePicUrl = URL(string: "https://graph.facebook.com/\(userId)/picture?type=small")
                    self.facebookProfileImage.layer.cornerRadius = self.facebookProfileImage.frame.size.width/2 //making image view circular.
                    self.facebookProfileImage.af.setImage(withURL: profilePicUrl!)
                    
                }
                
            })
            
            
            GraphRequest(graphPath: "/me/friends", parameters: ["field" : "total_count"] , httpMethod: .get).start { (connection, result, error) in
                
                if error == nil
                {
                    if let result = result
                    {
                        print("User Friends: \(result)")
                        print(JSON(result)["summary"]["total_count"].int)
                        
                        userFriendCount = String(JSON(result)["summary"]["total_count"].int ?? 0)
                        self.facebookFriendsCountLabel.text = userFriendCount
                        
                    }
                    
                }
            }
            

        }

        
    }
    
    

}
