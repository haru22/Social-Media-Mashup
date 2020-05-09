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

class ProfileViewController: UIViewController{

    @IBOutlet weak var facebookProfileImage: UIImageView!
    @IBOutlet weak var facebookFriendsCountLabel: UILabel!
    @IBOutlet weak var facebookPhotoCount: UILabel!
    @IBOutlet weak var facebookUserNameLabel: UILabel!
    
    @IBOutlet weak var instagramProfileImage: UIImageView!
    @IBOutlet weak var instagramUserNameLabel: UILabel!
    @IBOutlet weak var instagramPostsCount: UILabel!
    @IBOutlet weak var instagramFollowersCount: UILabel!
    @IBOutlet weak var instagramFollowingCount: UILabel!
    
    
    @IBOutlet weak var twitterProfileImage: UIImageView!
    @IBOutlet weak var twitterUsernameLabel: UILabel!
    @IBOutlet weak var twitterTweetsCount: UILabel!
    @IBOutlet weak var twitterFollowersCount: UILabel!
    @IBOutlet weak var twitterFollowingCount: UILabel!
    
    
    
    
    var instagramPageID: String = ""
    var  instagramAccountID: String = ""
    
    let loginManger = LoginManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       self.loadFacebookProfileInfo()
       self.getInstagramIDS()
        

        // Do any additional setup after loading the view.
    }
    



    @IBAction func logoutOnClick(_ sender: UIBarButtonItem) {
        PFUser.logOut()
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(identifier: "LoginViewController")
        let delegate = self.view.window?.windowScene?.delegate as! SceneDelegate
        delegate.window?.rootViewController = loginViewController
    }
    
    
    @IBAction func onFacebookLoginButton(_ sender: Any) {
        
        
        
        /*
          if let token = AccessToken.current,
              !token.isExpired {
              // User is logged in, do work such as go to next view controller.
          }*/
        
        
        
         loginManger.logIn(permissions: ["public_profile", "user_posts", "user_friends","user_photos"], from: self) { (result, error) in
             
             
             if let error = error {
               print("Failed to login: \(error.localizedDescription)")
               return
             }
        
             else
             {
                print("Successful Login!")
                self.loadFacebookProfileInfo()
                //self.getInstagramIDS()
                return
             }
             
          
             
          
        }
    }
    
    
    @IBAction func onTwitterLoginButton(_ sender: Any) {
        
        //print("on twitter login")
        let myUrl = "https://api.twitter.com/oauth/request_token"
        
        TwitterAPICaller.client?.login(url: myUrl, success: {
            
            print("log in sucessfully to twitter")
           
           
        }, failure: { (Error) in
            print("falide to sign in to twitter\n]=\(Error.localizedDescription)")
            
        })
        
        self.loadTwitterProfileInfo()
        
    }
    
    @IBAction func onInstagramLoginButton(_ sender: Any)
    {
        
        
           loginManger.logIn(permissions: ["public_profile", "user_posts", "user_friends","user_photos","instagram_basic", "pages_show_list"], from: self) { (result, error) in
               
               
               if let error = error {
                 print("Failed to login: \(error.localizedDescription)")
                 return
               }
          
               else
               {
                  print("Successful Login!")
                  //self.loadFacebookProfileInfo()
                  self.getInstagramIDS()
                  return
               }
    }
    }
    
    
    func getInstagramIDS()
    {
        if (AccessToken.current != nil  && (AccessToken.current?.hasGranted(permission: "instagram_basic") ?? false))
        {
           
            
            GraphRequest(graphPath: "/me/accounts", parameters: ["":""], httpMethod: .get).start { (connection, result, error) in
                if error == nil
                {
                    
                    if let result = result{
                        let temp = JSON(result)
                        self.instagramPageID = temp["data"][0]["id"].string!
                        //print("result from account id \(self.instagramPageID): \(temp) lets see")
                        
                        
                        
                        if(self.instagramPageID != "")
                        {
                            print("inside")
                            GraphRequest(graphPath: "/\(self.instagramPageID)", parameters: ["fields":"instagram_business_account"], httpMethod: .get).start { (connection, result, error) in
                                 if error == nil
                                 {
                                     
                                     if let result = result
                                     {
                                         let temp = JSON(result)
                                        self.instagramAccountID = temp["instagram_business_account"]["id"].string!
                                        //print("Information from instagram account \(self.instagramAccountID): \(temp)")
                                        self.loadInstagramProfileInfo()
                                     }
                                 }
                                 else
                                 {
                                     print(error?.localizedDescription)
                                 }
                             }

                         }
                     }
                 }
                else
                 {
                    print(error?.localizedDescription)
                 }
             }
        
            
        }
    }
    
       func loadInstagramProfileInfo()
       {
           
           
           print("PAGE ID: \(instagramPageID)  ACCOUNT ID \(instagramAccountID)")
        
            if(instagramAccountID != "")
            {
                GraphRequest(graphPath: "/\(instagramAccountID)", parameters: ["fields": "followers_count, follows_count,name, profile_picture_url, media_count, username "], httpMethod: .get).start { (connection, result, error) in
                    
                    if error == nil
                    {
                        if let result = result
                        {
                           let tempJson = JSON(result)
                            //print(tempJson)
                            
                            //setting the image
                            let profileImageUrl = URL(string: tempJson["profile_picture_url"].string!)
                            self.instagramProfileImage.layer.cornerRadius = self.instagramProfileImage.frame.size.width/2
                            self.instagramProfileImage.af.setImage(withURL: profileImageUrl!)
                            
                            //setting rest of user information
                            self.instagramFollowersCount.text = String(tempJson["followers_count"].int ?? 0)
                            self.instagramFollowingCount.text = String(tempJson["follows_count"].int ?? 0)
                            self.instagramPostsCount.text = String(tempJson["media_count"].int ?? 0)
                            self.instagramUserNameLabel.text = tempJson["username"].string!
                        }
                    }
                }
                
                
            }
           
               

    
       }
    
    
    func loadTwitterProfileInfo()
    {
        let profilePicUrl = URL(string: "https://graph.facebook.com/100050907580297/picture?type=small")!
        self.twitterProfileImage.layer.cornerRadius = self.twitterProfileImage.frame.size.width/2
        self.twitterProfileImage.af.setImage(withURL: profilePicUrl)
        self.twitterTweetsCount.text  = "20     "
        self.twitterFollowersCount.text = "90"
        self.twitterFollowingCount.text = "100"
        self.twitterUsernameLabel.text = "@kevinorellana2"
        
   
        
    }
    
    func loadFacebookProfileInfo()
    {
       // print("Loading facebook profile info")
        var userId: String = ""
        var userFriendCount: String = "0"
        
        if (AccessToken.current != nil)
        {
            
            //loading user's profile picture
            GraphRequest(graphPath: "me", parameters:  ["fields": "id, name"]).start(completionHandler: { connection, result, error in
                
                var userName: String = "Unknown"
                var jsonResponse : JSON
                if error == nil
                {
                        if let result = result {
                            //print("fetched user:\(result)")
                            jsonResponse = JSON(result)
                            userId = jsonResponse["id"].string!
                            userName = jsonResponse["name"].string ?? "Unkown"
                            
                           // print("User Id: \(userId)")
                        }
                }
            
                if userId != ""
                {
                    //print("Loading profile image")
                    let profilePicUrl = URL(string: "https://graph.facebook.com/\(userId)/picture?type=small")
                    self.facebookProfileImage.layer.cornerRadius = self.facebookProfileImage.frame.size.width/2 //making image view circular.
                    self.facebookProfileImage.af.setImage(withURL: profilePicUrl!)
                    
                }
                
                self.facebookUserNameLabel.text = userName
                
            })
            
            
            //determining number of friends
            GraphRequest(graphPath: "/me/friends", parameters: ["field" : "total_count"] , httpMethod: .get).start { (connection, result, error) in
                
                if error == nil
                {
                    if let result = result
                    {
                        
                        //getting the number of user friends.
                        userFriendCount = String(JSON(result)["summary"]["total_count"].int ?? 0)
                        self.facebookFriendsCountLabel.text = userFriendCount
                        
                    }
                    
                }
            }
            
            
            //determining number of pictures
            GraphRequest(graphPath: "/me/albums", parameters: ["fields": "name, count"], httpMethod: .get).start { (connection, result, error) in
                
                if error == nil
                {
                    
                    if let result = result
                    {
                        let albumData = JSON(result)["data"]
                        let albumCount: Int = albumData.count
                        var loopCounter: Int = 0
                        var photoCount: Int = 0
                        
                        //determining the number of pictures in each of the user's albums
                        while (loopCounter < albumCount)
                        {
                           
                            photoCount += albumData[loopCounter]["count"].int ?? 0
                            loopCounter += 1
                        }
                        
                        self.facebookPhotoCount.text = String(photoCount) //updating photo count in the UI
                       
                    }
                }
                
            }
    
            
            

        }

        
    }
    
    @IBAction func onFacebookLogOff(_ sender: Any) {
        
        loginManger.logOut()
    }
    
    
    

}
