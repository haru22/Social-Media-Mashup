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
    var identifier : Int  //1->facebook  2->Instagram  3->Twitter
    var userName : String
    var profileImageURL : URL
    var postImageURL: URL
    var postTextContent: String
    var likeCount : Int
    var commentCount: Int
    var containsImage: Bool
    var timeStamp: String
    
    init(inputIdentifier: Int, inputUsername: String, inputProfileImageURL: URL, inputPostImageURL: URL, inputPostTextContent: String, inputLikeCount: Int, inputCommentCount: Int, inputContainsImage: Bool, inputTimeStamp: String)
    {
        self.identifier = inputIdentifier
        self.userName = inputUsername
        self.profileImageURL = inputProfileImageURL
        self.postImageURL = inputPostImageURL
        self.postTextContent = inputPostTextContent
        self.likeCount = inputLikeCount
        self.commentCount = inputCommentCount
        self.containsImage = inputContainsImage
        self.timeStamp = inputTimeStamp
        
        
    }
    public func description() -> String
    {
        
        return "SocialFeed\n\(self.identifier)\n\(self.userName)\n\(self.profileImageURL)\n\(self.postImageURL)\n\(self.postTextContent)\n\(self.likeCount)\n\(self.commentCount)\n\(self.containsImage)\n\(self.timeStamp)"
        
    }
    
    
    
    
    
}
