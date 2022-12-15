//
//  UserService.swift
//  PhotoApp
//
//  Created by Afir Thes on 15.12.2022.
//

import Foundation
import FirebaseFirestore

class UserService {
    
    static func createProfile(userId: String, username: String, completion: @escaping (PhotoUser?)->Void) {
        let db = Firestore.firestore()
        
        db.collection("users").document(userId).setData([
            "username":username
        ]) { error in
            
            if error == nil {
                print("Profile create successfylly")
                var u = PhotoUser()
                u.username = username
                u.userId = userId
                completion(u)
            } else {
                print("Something went wrong")
                completion(nil)
            }
            
        }
    }
    
    static func retrieveProfile(userId: String, completion: @escaping (PhotoUser?)->Void) {
        let db = Firestore.firestore()
        
        db.collection("users").document(userId).getDocument { snapshot, error in
            if error != nil || snapshot == nil {
                return
            }
            
            if let profile = snapshot!.data() {
                var u = PhotoUser()
                u.userId = snapshot!.documentID
                u.username = profile["username"] as? String
                
                completion(u)
            } else {
                completion(nil)
            }
        }
    }
    
    
}
