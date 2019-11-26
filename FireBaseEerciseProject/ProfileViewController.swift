//
//  ProfileViewController.swift
//  FireBaseEerciseProject
//
//  Created by EsraaGK on 11/25/19.
//  Copyright © 2019 EsraaGK. All rights reserved.
//

import UIKit
import SDWebImage
import FirebaseFirestore
import FirebaseStorage

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var coverImg: UIImageView!
    
    @IBOutlet weak var emailLable: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var nameLable: UILabel!
    let imagePicker = UIImagePickerController()
    // Get a reference to the storage service using the default Firebase App
    let storage = Storage.storage()
    let db = Firestore.firestore()
    var alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
    var pickImageCallback : ((UIImage) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImg.setRounded()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        // Add a second document with a generated ID.
        db.collection("Profiles").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    
                    let profileUrl = data["profileUrl"] as? String
                    self.profileImg.sd_setImage(with: URL(string: profileUrl!), placeholderImage: UIImage(named: "jolia"))
                    
                    let coverUrl = data["coverUrl"] as? String
                    self.coverImg.sd_setImage(with: URL(string: coverUrl!), placeholderImage: UIImage(named: "jolia"))
                    
                    let name = data["name"] as? String
                    self.nameLable.text = name!
                    let email = data["email"] as? String
                    self.emailLable.text = email!
                }
            }
        }
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
        guard let image = info[.originalImage] as? UIImage,
            let imageURL =  info[.imageURL] as? URL else {
                fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        profileImg.image = image
        let choosenImageName = imageURL.lastPathComponent
        
        let data1 = image.compress(.medium)
        uploadToFirebaseStorage(data: data1!, imageName: choosenImageName)
        
        guard let img = info[.editedImage] as? UIImage,
            let imgURL =  info[.imageURL] as? URL else{
                fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        profileImg.image = img
        let data2 = img.compress(.low)
        let editedImageName = imgURL.lastPathComponent
        uploadToFirebaseStorage(data: data2!, imageName: editedImageName)
    }
    
    func uploadToFirebaseStorage(data:Data, imageName: String){
        
        // Create a storage reference from our storage service
        let storageRef = storage.reference()
    
        // Create a reference to 'images/mountains.jpg'
        let mountainImagesRef = storageRef.child(imageName)
        
        _ = mountainImagesRef.putData(data, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
                // Uh-oh, an error occurred!
                return
            }
            // Metadata contains file metadata such as size, content-type.
            _ = metadata.size
            // You can also access to download URL after upload.
            mountainImagesRef.downloadURL { (URL, Error) in
                guard let url = URL else {return}
                self.db.collection("Profiles").document("ID").updateData(["profileUrl": url.absoluteString])
            }
            
        }
        
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, pickedImage: UIImage?) {
    }
    
    
}
