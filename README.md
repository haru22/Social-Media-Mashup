# SocialOne

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
This app offers the user the ability to manage three of the most popular social media platform in one place. 


### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:** Social Media
- **Mobile:** Uses camera and real-time information.
- **Story:** Allows the user to manage their social media account platforms in one place. 
- **Market:** Anyone who uses various social media platforms can benefit from this app. However, it is mainly focused at content creators. 
- **Habit:** Users can view the posts of other users many times throught the day. Addittionally, users have the ability to create posts that other users will be able to see.
- **Scope:** This app will use heavily the APIs provided by Facebook, Twitter, and Instagram. At its very core, this app will enable the user to see the feeds of these three social media platforms as well as create post for them. 

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* User Login Page.
* User is required to have either both Facebook, Twitter or Instagram account.
* User able to view feeds from three different platforms of social media
* User able to view their profile information
* Profile page
* News Feed Page
*

**Optional Nice-to-have Stories**

* Post to Instagram or Facebook story
* Post new photo to Instagram or Facebook. 
*

### 2. Screen Archetypes

* Login Screen
   * User must login to their either Facebook, Twitter or Instagram account
   * User will be redirected to a different screen to authenticate and authorize our application accessing thier account information
   
* Feed Screen
   * User will be able to see the post feeds of each platform combined.
   * User will be able to "like" "retweet" and "comment" to the corresponding posts.
* Profile Screen
    *  User able view their profile information
    *  User is able to view which social media accounts he/she is signed into. 
    
* Post Screen
    * User is able to create post for each of the social media platforms. 

* Setting Screen
    * User will be able to set preferences such as remembering their login credentials.



### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Feed Screen
* Profile Screen
* Post Screen

**Flow Navigation** (Screen to Screen)

* Login Screen
   * Feed Screen

* Profile Screen
   * Setting Screen

* Post Screen
    * Feed Screen

## Wireframes

### [BONUS] Digital Wireframes & Mockups
<img src="https://i.imgur.com/Vn6fjaL.png" width=600>

### [BONUS] Interactive Prototype

## Schema 
### Models

#### User

|  Property | Type | Description |
| -------- | -------- | -------- |
| objectID     | String     | Unique ID for each user     |
| email | String | User email |
| password | String | User encrypted password |
| name | String | First and last name |

### Networking

List of network requests by screen
* Home Feed Screen
    * (Read/GET) Query all posts where user is author 
        ```
        let query = PFQuery(className: "Posts")
        query.includeKeys(["author","comments", "comments.author"]) 
        query.limit = 20
        
        query.findObjectsInBackground { (posts, error) in
            if posts != nil {
                self.posts = posts!
                self.tableView.reloadData()
            }
        }
    
    * (Create/POST) Create a new like on a post
    * (Delete) Delete existing like
    * (Create/POST) Create a new comment on a post
    * (Delete) Delete existing comment
* Create Post Screen
    * (Create/POST) Create a new post object
        ```
        let post = PFObject(className: "Posts")
        post["caption"] = commentField.text
        post["author"] = PFUser.current()!
        
        let imageData = imageView.image!.pngData()
        let file = PFFileObject(name: "image.png", data: imageData!)
        
        post["image"] = file
        
        post.saveInBackground{ (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
                print("saved")
            } else {
                print("error")
            }
        }

    

- [Create basic snippets for each Parse network request]

### [OPTIONAL:] Existing API Endpoints
Instagram API
- Base Url - https://api.instagram.com/v1

| HTTP Verb | Endpoint | Description |
| -------- | -------- | -------- |
| GET     | /users/self       |  Get information about the user currently logged in     |
| GET     | /users/self/media/recent      |  Get the most recent media of the user currently logged in     |
| GET     | /media/media-id/comments      | Get the list of recent comments on a media object     |
| POST     | /{ig-user-id}/media_publish      | Post media object on instagram     |


Twitter API
- Base URL - https://developer.twitter.com/en/docs/tweets/timelines/overview

| HTTP Verb | Endpoint | Description |
| -------- | -------- | -------- |
| GET     | /home_timeline     | Returns a collection of the most recent Tweets posted by the authenticating user and the users they follow.     |
| GET | statuses / user_timeline | Returns a collection of the most recent Tweets posted by the indicated by the screen_name or user_id parameters.



Facebook API
- Base URL - https://developers.facebook.com/docs/graph-api/reference/v6.0/user/feed


| HTTP Verb | Endpoint | Description |
| -------- | -------- | -------- |
| GET     | /{user-id}/posts     | shows only the posts that were published by this person.     |
| GET    | /{user-id}/tagged   |shows only the posts that this person was tagged in.

## Build Progress

<img src="https://recordit.co/vI8NF71eqX.gif" width=250>

<img src= "https://recordit.co/Sf1oIieLTz.gif" width=250>

