//
//  PostViewController.swift
//  SocialOne
//
//  Created by admin on 5/5/20.
//  Copyright © 2020 Benny Ooi. All rights reserved.
//

import UIKit
import AlamofireImage
import FBSDKShareKit

class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var postImage: UIImageView!
    
    @IBOutlet weak var commentTextField: UITextField!
    
    let content = SharePhotoContent()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    

    @IBAction func onSubmitButton(_ sender: Any)
    {
        let button = FBShareButton()
        button.shareContent = content
        view.addSubview(button)
        
    /*

        let dialog = ShareDialog()
        dialog.fromViewController = self
        dialog.shareContent = content
        dialog.mode = SharePhotoContent
        dialog.show()*/
        
        
        
    }
    

    @IBAction func onCameraButton(_ sender: Any)
    {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        
        if(UIImagePickerController.isSourceTypeAvailable(.camera))
        {
            picker.sourceType = .camera
        }
        else
        {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        
        //Gathering user Uploaded image
        let image = info [.editedImage] as! UIImage
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageScaled(to: size)
        
        
        
        //preparing for the image to be shared with facebook
        let facebookPhoto = SharePhoto()
        facebookPhoto.image = scaledImage
        facebookPhoto.isUserGenerated = true
        if let facebookCaption = commentTextField.text //if there is a caption
        {
            print("Facebook Caption: \(facebookCaption)")
            facebookPhoto.caption = facebookCaption
        }
       
        content.photos = [facebookPhoto]
        
        //Showing the image that was selected on screen.
        postImage.image =  scaledImage
        
        dismiss(animated: true, completion: nil)
        


        
        
        
    }
}
