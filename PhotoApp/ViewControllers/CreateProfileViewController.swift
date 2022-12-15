//
//  CreateProfileViewController.swift
//  PhotoApp
//
//  Created by Afir Thes on 14.12.2022.
//

import UIKit
import FirebaseAuth

class CreateProfileViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    

    @IBAction func confirmTapped(_ sender: Any) {
        guard let loggedUser = Auth.auth().currentUser else { return }
        
        guard let username = usernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !username.isEmpty else {
            
            return
        }
        
        UserService.createProfile(userId: loggedUser.uid, username: username) { user in
            
            guard let user = user else {
                
                return
            }
            
            LocalStorageService.saveUser(userId: user.userId, username: user.username)
            let tabBarVC = self.storyboard?.instantiateViewController(withIdentifier: Constants.mainTabVC)
            self.view.window?.rootViewController = tabBarVC
            self.view.window?.makeKeyAndVisible()
        }
    }
    
}
