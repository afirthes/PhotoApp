//
//  PhotoCell.swift
//  PhotoApp
//
//  Created by Afir Thes on 18.12.2022.
//

import UIKit

class PhotoCell: UITableViewCell {
    
    static let cellId = "PhotoCell"

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    var photo:Photo?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func displayPhoto(photo: Photo) {
        
        
        self.photoImageView.image = nil
        
        self.photo = photo
        
        usernameLabel.text = photo.byUsername
        dateLabel.text = photo.date
        
        if photo.url == nil {
            return
        }
        
        if let cachedImage = ImageCacheService.getImage(url: photo.url!) {
            self.photoImageView.image = cachedImage
            return
        }
        
        let url = URL(string: photo.url!)
        
        if url == nil {
            return
        }
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!) { data, response, error in
            if error == nil && data != nil {
                guard let image = UIImage(data: data!) else { return }
                
                ImageCacheService.saveImage(url: url!.absoluteString, image: image)
                
                if url!.absoluteString != self.photo?.url {
                    return
                }
                
                DispatchQueue.main.async {
                    self.photoImageView.image = image
                }

            }
        }
        dataTask.resume()
    }

}
