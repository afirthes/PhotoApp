//
//  LocalStorageService.swift
//  PhotoApp
//
//  Created by Afir Thes on 15.12.2022.
//

import Foundation

class LocalStorageService {
    
    static func saveUser(userId: String?, username: String?) {
        let defaults = UserDefaults.standard
        
        defaults.setValue(userId, forKey: Constants.storedIdKey)
        defaults.setValue(username, forKey: Constants.storedUsernameKey)
    }
    
    static func loadUser() -> PhotoUser? {
        let defaults = UserDefaults.standard
        
        let username = defaults.value(forKey: Constants.storedUsernameKey) as? String
        let userId = defaults.value(forKey: Constants.storedIdKey) as? String
         
        if userId != nil, username != nil {
            return PhotoUser(userId: userId, username: username)
        } else {
            return nil
        }
    }
    
    static func clearUser() {
        let defaults = UserDefaults.standard
        defaults.setValue(nil, forKey: Constants.storedIdKey)
        defaults.setValue(nil, forKey: Constants.storedUsernameKey)
    }
}
