//
//  PhotoService.swift
//  PhotoApp
//
//  Created by Afir Thes on 15.12.2022.
//

import Foundation
import UIKit
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth

class PhotoService {
    
    static func retrievePhotos(completion: @escaping ([Photo]) -> Void) {
        
        let db = Firestore.firestore()
        let store = Storage.storage().reference()
        
        db.collection("photos").getDocuments { snapshot, error in
            
            if error != nil {
                print("error retrieving photos", error)
                return
            }
            
            if let documents = snapshot?.documents {
                var photoArray = [Photo]()
                for doc in documents {
                    let p = Photo(snapshot: doc)
                    if let p = p {
                        photoArray.insert(p, at: 0)
                    }
                }
                completion(photoArray)
            }
        }
    }
    
    static func savePhoto(image: UIImage, progressUpdate: @escaping (Double) -> Void) {
        
        guard let user = Auth.auth().currentUser else { return }
        
        guard let photoData = image.jpegData(compressionQuality: 0.1) else {
            print("Couldn't get data from UIImage")
            return
        }
        
        let filename = UUID().uuidString
        
        let userId = user.uid
        
        let ref = Storage.storage().reference().child("images/\(userId)/\(filename).jpg")
        
        let upoloadTask = ref.putData(photoData, metadata: nil) { result in
            
            switch result {
            case .failure(let error):
                print(error)
                break;
            case .success(let storageMetadata):
                
                self.createDatabaseEntry(ref: ref)
                break;
            }
            
        }
        
        upoloadTask.observe(.progress) { taskSnapshot in
            let completed = taskSnapshot.progress!.completedUnitCount
            let total = taskSnapshot.progress!.totalUnitCount
            let percentage = Double(completed) / Double(total)
            print(percentage)
            progressUpdate(percentage)
        }

    }
    
    static private func createDatabaseEntry(ref: StorageReference) {
        let downloadUrl = ref.downloadURL { url, error in
            guard let url = url, error == nil else { return }
            
            let photoUser = LocalStorageService.loadUser()
            
            let photoId = ref.fullPath
            
            let userId = photoUser?.userId
            
            let username = photoUser?.username
            
            let df = DateFormatter()
            df.dateStyle = .full
            
            let dateString = df.string(from: Date())
            
            let metadata = [
                "photoId": photoId,
                "byId": userId,
                "byUsername": username,
                "date": dateString,
                "url": url.absoluteString
            ]
            
            let db = Firestore.firestore()
            
            db.collection("photos").addDocument(data: metadata) { error in
                if error == nil {
                    print("Image database entry saved")
                }
            }
        }
    }
}
