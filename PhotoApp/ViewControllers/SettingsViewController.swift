//
//  SettingsViewController.swift
//  PhotoApp
//
//  Created by Afir Thes on 14.12.2022.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func signOutTapped(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            LocalStorageService.clearUser()
            
            let loginNavVC = storyboard?.instantiateViewController(withIdentifier: Constants.loginNavVC)
            
            view.window?.rootViewController = loginNavVC
            view.window?.makeKeyAndVisible()
        } catch {
            print("coldn't sign out the user")
        }
        
    }
    

}
