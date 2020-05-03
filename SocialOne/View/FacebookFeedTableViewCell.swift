//
//  FacebookFeedTableViewCell.swift
//  SocialOne
//
//  Created by admin on 5/2/20.
//  Copyright © 2020 Benny Ooi. All rights reserved.
//

import UIKit

class FacebookFeedTableViewCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var postContentLabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
