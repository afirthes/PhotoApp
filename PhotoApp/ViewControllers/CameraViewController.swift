//
//  CameraViewController.swift
//  PhotoApp
//
//  Created by Afir Thes on 14.12.2022.
//

import UIKit

class CameraViewController: UIViewController {


    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    func savePhoto(image: UIImage) {
        
        self.progressBar.isHidden = false
        
        PhotoService.savePhoto(image: image) { pct in
            
            DispatchQueue.main.async {
                
                self.progressBar.setProgress(Float(pct), animated: true)
                
                self.progressLabel.text = "\( Int(pct * 100) ) %"
                self.progressLabel.isHidden = false
                
                if pct == 1 {
                    self.doneButton.isHidden = false
                    self.progressLabel.text = "Upload completed!"
                }
            }
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.progressBar.isHidden = true
        self.progressBar.setProgress(Float(0), animated: false)
        self.progressLabel.isHidden = true
        self.doneButton.isHidden = true
    }

    @IBAction func doneTapped(_ sender: Any) {
        let tabBarVC = self.tabBarController as? MainTabBarController
        
        if let tabBarVC = tabBarVC {
            
            tabBarVC.goToFeed()
        }
    }
}
