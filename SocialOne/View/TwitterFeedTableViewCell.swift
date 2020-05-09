//
//  TwitterFeedTableViewCell.swift
//  SocialOne
//
//  Created by admin on 5/9/20.
//  Copyright © 2020 Benny Ooi. All rights reserved.
//

import UIKit

class TwitterFeedTableViewCell: UITableViewCell {

    
    @IBOutlet weak var twitterProfileImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var postTextContent: UILabel!
    
    @IBOutlet weak var postImageContext: UIImageView!
    
    @IBOutlet weak var commentCount: UILabel!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var likeCount: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
