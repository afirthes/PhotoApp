//
//  Photo.swift
//  PhotoApp
//
//  Created by Afir Thes on 15.12.2022.
//

import Foundation
import FirebaseFirestore

struct Photo {
    
    var photoId: String?
    var byId: String?
    var byUsername: String?
    var date: String?
    var url: String?
    
    init?(snapshot:QueryDocumentSnapshot) {
        let data = snapshot.data()
        let photoId = data["photoId"] as? String
        let userId = data["byId"] as? String
        let username = data["byUsername"] as? String
        let date = data["date"] as? String
        let url = data["url"] as? String
        
        if let photoId = photoId, let userId = userId,
           let username = username, let url = url, let date = date {
            self.photoId = photoId
            self.byId = userId
            self.byUsername = username
            self.date = date
            self.url = url
        } else {
            return nil
        }
    }
    
}
