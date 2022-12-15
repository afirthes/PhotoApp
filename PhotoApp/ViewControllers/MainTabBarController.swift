//
//  MainTabBarController.swift
//  PhotoApp
//
//  Created by Afir Thes on 15.12.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        if item.tag == 2 {
            var actionSheet = UIAlertController(title: "Add a Photo", message: "Select a source", preferredStyle: .actionSheet)
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                var cameraButton = UIAlertAction(title: "Camera", style: .default) { action in
                    self.showImagePickerController(mode: .camera)
                }
                actionSheet.addAction(cameraButton)
            }
            
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let libraryButton = UIAlertAction(title: "Photo Library", style: .default) { action in
                    self.showImagePickerController(mode: .photoLibrary)
                }
                actionSheet.addAction(libraryButton)
            }
            
            let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            actionSheet.addAction(cancelButton)
            
            present(actionSheet, animated: true, completion: nil)
        }
    }
    
    func showImagePickerController(mode: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = mode
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
    }
    
}

extension MainTabBarController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        
        if let selectedImage = selectedImage {
            var cameraVC = self.selectedViewController as? CameraViewController
            
            if let cameraVC = cameraVC {
                cameraVC.savePhoto(image: selectedImage)
            }
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func goToFeed() {
        selectedIndex = 0 // first tab
    }
}
