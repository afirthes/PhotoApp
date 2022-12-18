//
//  FeedViewController.swift
//  PhotoApp
//
//  Created by Afir Thes on 14.12.2022.
//

import UIKit

class FeedViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var photos = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        addRefreshControl()

        PhotoService.retrievePhotos { photos in
            self.photos = photos
            self.tableView.reloadData()
        }
        
        
    }
    
    func addRefreshControl() {
        let refresh = UIRefreshControl()
        
        refresh.addTarget(self, action: #selector(refreshFeed(refreshControl:)), for: .valueChanged)
        
        self.tableView.addSubview(refresh)
    }
    
    @objc
    func refreshFeed(refreshControl: UIRefreshControl) {
        PhotoService.retrievePhotos { newPhotos in
            self.photos = newPhotos
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                refreshControl.endRefreshing()
            }
        }
    }
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        let photo = self.photos[indexPath.row]
        cell.displayPhoto(photo: photo)
        return cell
    }
    
    
    
}
