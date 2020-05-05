//
//  PostViewController.swift
//  SocialOne
//
//  Created by admin on 5/5/20.
//  Copyright © 2020 Benny Ooi. All rights reserved.
//

import UIKit
import AlamofireImage

class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var postImage: UIImageView!
    
    @IBOutlet weak var commentTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    

    @IBAction func onSubmitButton(_ sender: Any)
    {
        
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
        let image = info [.editedImage] as! UIImage
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageScaled(to: size)
        
        postImage.image =  scaledImage
        
        dismiss(animated: true, completion: nil)
        
        
        
    }
}
