//
//  ProfileViewController.swift
//  FireBaseEerciseProject
//
//  Created by EsraaGK on 11/25/19.
//  Copyright © 2019 EsraaGK. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var coverImg: UIImageView!
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var nameLable: UILabel!
    let imagePicker = UIImagePickerController()
    var alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
    var pickImageCallback : ((UIImage) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImg.setRounded()
        imagePicker.delegate = self
    }
    
    @IBAction func chooseProfilePhoto(_ sender: UITapGestureRecognizer) {
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default){
            UIAlertAction in
            self.openCamera()
        }
        let galleryAction = UIAlertAction(title: "Gallery", style: .default){
            UIAlertAction in
            self.openGallery()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){
            UIAlertAction in
        }

        // Add the actions
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
       }
    func openCamera(){
        alert.dismiss(animated: true, completion: nil)
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            imagePicker.sourceType = .camera
            self.present(imagePicker, animated: true, completion: nil)
        }
        
    }
    
    func openGallery(){
            alert.dismiss(animated: true, completion: nil)
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }


        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
    }

      // For Swift 4.2
      func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
          picker.dismiss(animated: true, completion: nil)
          guard let image = info[.originalImage] as? UIImage else {
              fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
          }
        profileImg.image = image
      }



        @objc func imagePickerController(_ picker: UIImagePickerController, pickedImage: UIImage?) {
        }


}
