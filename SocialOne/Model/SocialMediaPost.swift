//
//  SocialMediaPost.swift
//  SocialOne
//
//  Created by admin on 5/8/20.
//  Copyright © 2020 Benny Ooi. All rights reserved.
//

import Foundation


class SocialMediaPost
{
    var identifier : Int = -1 //1->facebook  2->Instagram  3->Twitter
    var userName : String = ""
    var profileImageURL : URL = URL(string: "")!
    var postImageURL: URL = URL(string: "")!
    var postTextContent: String = ""
    var likeCount : Int = -1
    var commentCount: Int = 1
    var containsImage: Bool  = false
    
    init(inputIdentifier: Int, inputUsername: String, inputProfileImageURL: URL, inputPostImageURL: URL, inputPostTextContent: String, inputLikeCount: Int, inputCommentCount: Int, inputContainsImage: Bool)
    {
        self.identifier = inputIdentifier
        self.userName = inputUsername
        self.profileImageURL = inputProfileImageURL
        self.postImageURL = inputPostImageURL
        self.postTextContent = inputPostTextContent
        self.likeCount = inputLikeCount
        self.commentCount = inputCommentCount
        self.containsImage = inputContainsImage
        
        
        
        
        
    }
    
    
    
    
    
    
}
