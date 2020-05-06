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
    

    

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        tableView.delegate = self
        tableView.dataSource = self
        
     

        // Do any additional setup after loading the view.
    }
   
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
      //  Converted to Swift 5.1 by Swiftify v5.1.31847 - https://swiftify.com/
            if (AccessToken.current != nil)
            {
                GraphRequest(graphPath: "me", parameters:  ["fields": "id, name, about"]).start(completionHandler: { connection, result, error in
                        if error == nil {
                                if let result = result {
                                    //print("fetched user:\(result)")
                                }
                            }
                        })
            }
                      
                      
                let request = GraphRequest(graphPath: "/me/feed", parameters: ["fields":"name, from, message, full_picture" ], httpMethod: .get)
                      request.start(completionHandler: { connection, result, error in
                          
                          if error == nil
                          {
                              
                            self.apiResult = JSON(result)
                            //print("Json Result new \(self.apiResult)")
                           // print("IMage URl: \(self.apiResult["data"][0]["full_picture"].string ?? "false")")
                            self.loaded = true
                            self.tableView.reloadData()
                             
                    

                          }
                      
                          
                      })

                        print("AT THE END OF PROFILE USER")
                    self.tableView.reloadData()
        
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
            if(self.apiResult["data"][indexPath.row]["full_picture"].string == nil)
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "FacebookFeedTwoTableViewCell") as! FacebookFeedTwoTableViewCell
                cell.usernameLabel.text = self.apiResult["data"][indexPath.row]["from"]["name"].string ?? "error"
                cell.postContent.text = self.apiResult["data"][indexPath.row]["message"].string ?? "error"
                return cell
            }
            
            else
            {
                var imageUrl = URL(string: apiResult["data"][indexPath.row]["full_picture"].string!)
                let cell = tableView.dequeueReusableCell(withIdentifier: "FacebookFeedTableViewCell") as! FacebookFeedTableViewCell
                
                cell.usernameLabel.text = self.apiResult["data"][indexPath.row]["from"]["name"].string ?? "error"
                cell.postContentLabel.text = self.apiResult["data"][indexPath.row]["message"].string ?? "error"
                cell.postImage.af_setImage(withURL: imageUrl!)
                
                return cell
                
            }
        }
        
        return tableView.dequeueReusableCell(withIdentifier: "LoadingTableViewCell") as! LoadingTableViewCell

  }

}
