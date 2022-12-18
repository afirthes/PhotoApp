//
//  ImageCacheService.swift
//  PhotoApp
//
//  Created by Afir Thes on 18.12.2022.
//

import UIKit


class ImageCacheService {
    
    static var imageCache = [String:UIImage]()
    
    static func saveImage(url:String?, image:UIImage?) {
        if url == nil || image == nil {
            return
        }
        
        imageCache[url!] = image!
    }
    
    static func getImage(url:String?) -> UIImage? {
        if url == nil {
            return nil
        }
        
        return imageCache[url!]
    }
}
