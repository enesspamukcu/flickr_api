//
//  PhotoDetailViewController.swift
//  Flickr Client App
//
//  Created by mono on 2.07.2022.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    
    var photo:Photo?

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var ownerImageView: UIImageView!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.backgroundColor = .gray
        ownerNameLabel.text = "Owner Name"
        descriptionLabel.text = "Description Label Description Label Description Label Description Label Description Label"
        
            NetworkManager.shared.fetchImage(with: photo?.buddyIconUrl) { data in
                self.ownerImageView.image = UIImage(data: data)
        }
        ownerNameLabel.text = photo?.ownername
        NetworkManager.shared.fetchImage(with: photo?.urlZ, competion: { data in
            self.imageView.image = UIImage(data:data)
        })
        title = photo?.title
        descriptionLabel.text = photo?.photoDescription?.content
    }
    
}
