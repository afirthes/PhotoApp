//
//  LoginViewController.swift
//  PhotoApp
//
//  Created by Afir Thes on 14.12.2022.
//

import UIKit
import FirebaseAuthUI
import FirebaseEmailAuthUI

class LoginViewController: UIViewController, FUIAuthDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func loginTapped(_ sender: Any) {
        let authUI = FUIAuth.defaultAuthUI()
        
        if let authUI = authUI {
            
            authUI.delegate = self
            authUI.providers = [FUIEmailAuth()]
            let authViewController = authUI.authViewController()
            present(authViewController, animated: true, completion: nil)
        }
    }
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        
        if error != nil {
            print(error!.localizedDescription)
            return
        }
        
        let user = authDataResult?.user
        
        if let user = user {
            UserService.retrieveProfile(userId: user.uid) { user in
                guard let user = user else {
                    self.performSegue(withIdentifier: Constants.profileSeque, sender: self)
                    return
                }
                
                LocalStorageService.saveUser(userId: user.userId, username: user.username)
                
                let tabBarVC = self.storyboard?.instantiateViewController(withIdentifier: Constants.mainTabVC)
                
                guard let tabBarVC = tabBarVC else { return }
                
                self.view.window?.rootViewController = tabBarVC
                self.view.window?.makeKeyAndVisible()
            }
        }
    }
}
