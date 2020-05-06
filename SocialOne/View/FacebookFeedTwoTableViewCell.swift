//
//  FacebookFeedTwoTableViewCell.swift
//  SocialOne
//
//  Created by admin on 5/3/20.
//  Copyright © 2020 Benny Ooi. All rights reserved.
//

import UIKit

class FacebookFeedTwoTableViewCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var postContent: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
