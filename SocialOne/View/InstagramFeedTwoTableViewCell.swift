//
//  InstagramFeedTwoTableViewCell.swift
//  SocialOne
//
//  Created by admin on 5/8/20.
//  Copyright © 2020 Benny Ooi. All rights reserved.
//

import UIKit

class InstagramFeedTwoTableViewCell: UITableViewCell {

    @IBOutlet weak var instagramUsername: UILabel!
    @IBOutlet weak var instagramProfilePicture: UIImageView!
    @IBOutlet weak var instagramPostContent: UILabel!
    
    @IBOutlet weak var instagramNumberOfLikesLabel: UILabel!
    @IBOutlet weak var instagramNumberOfCommentsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
