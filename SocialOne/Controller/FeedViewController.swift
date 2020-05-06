//
//  FeedViewController.swift
//  SocialOne
//
//  Created by Benny Ooi Kean Hoe on 4/25/20.
//  Copyright © 2020 Benny Ooi. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import SwiftyJSON

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
      
    
    var apiResult: JSON = JSON()
    var loaded: Bool = false
    let myRefreshControl = UIRefreshControl()
    

    @IBOutlet weak var tableView: UITableView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.delegate = self
        tableView.dataSource = self
        
        loadFacebookFeed()
        
        //implementing "pull down to refresh"
        myRefreshControl.addTarget(self, action: #selector(loadFacebookFeed), for: .valueChanged)
        tableView.refreshControl = myRefreshControl
        
     

    }
   
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)


        
    }

    
          
    
    /*
     This function loads all the posts from the user's facebook feed and stores it on "apiResult"
     */
    @objc func loadFacebookFeed()
    {
        
        if (AccessToken.current != nil)
        {
            /*
            GraphRequest(graphPath: "me", parameters:  ["fields": "id, name, about"]).start(completionHandler: { connection, result, error in
                    if error == nil {
                            if let result = result {
                                //print("fetched user:\(result)")
                            }
                        }
                    })
 */
        
                  
                  
            let request = GraphRequest(graphPath: "/me/feed", parameters: ["fields":"name, from, message, full_picture" ], httpMethod: .get)
            
            request.start(completionHandler: { connection, result, error in
                if error == nil
                      {
                          
                        self.apiResult = JSON(result)
                        print("Json Result new \(self.apiResult)")
                       // print("IMage URl: \(self.apiResult["data"][0]["full_picture"].string ?? "false")")
                        self.loaded = true
                        self.tableView.reloadData()

                      }
                  })

        }
        else
        {
            loaded = false
            self.tableView.reloadData()
        }
        
        
        print("AT THE END OF PROFILE USER")
        self.myRefreshControl.endRefreshing()
               // self.tableView.reloadData()
        
    }

    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(loaded)
        {
            return self.apiResult["data"].count
        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        
        if(loaded)
        {
            if(self.apiResult["data"][indexPath.row]["full_picture"].string == nil)//if post does not contain an post image
            {
                let userId = apiResult["data"][indexPath.row]["from"]["id"].string ?? ""
                let profileImageUrl = URL(string: "https://graph.facebook.com/\(userId)/picture?type=small")
                let cell = tableView.dequeueReusableCell(withIdentifier: "FacebookFeedTwoTableViewCell") as! FacebookFeedTwoTableViewCell
                cell.usernameLabel.text = self.apiResult["data"][indexPath.row]["from"]["name"].string ?? "error"
                cell.postContent.text = self.apiResult["data"][indexPath.row]["message"].string ?? "error"
                cell.profileImage.layer.cornerRadius = cell.profileImage.frame.size.width/2 //making the image to have a round shapte
                cell.profileImage.af.setImage(withURL: profileImageUrl!)
                return cell
            }
            
            else
            {
                let userId = apiResult["data"][indexPath.row]["from"]["id"].string ?? ""
                let profileImageUrl = URL(string: "https://graph.facebook.com/\(userId)/picture?type=small")
                let postImageUrl = URL(string: apiResult["data"][indexPath.row]["full_picture"].string!)
                let cell = tableView.dequeueReusableCell(withIdentifier: "FacebookFeedTableViewCell") as! FacebookFeedTableViewCell
                
                cell.usernameLabel.text = self.apiResult["data"][indexPath.row]["from"]["name"].string ?? "error"
                cell.postContentLabel.text = self.apiResult["data"][indexPath.row]["message"].string ?? "error"
                cell.postImage.af.setImage(withURL: postImageUrl!)
                cell.profileImage.layer.cornerRadius = cell.profileImage.frame.size.width/2 //setting the image to have a round shape
                cell.profileImage.af.setImage(withURL: profileImageUrl!)
                
                print("Image Profile Url: \(profileImageUrl!)")
                
                return cell
                
            }
        }
        
        return tableView.dequeueReusableCell(withIdentifier: "LoadingTableViewCell") as! LoadingTableViewCell

  }

}
