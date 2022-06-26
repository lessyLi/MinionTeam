//
//  PhotoCollectionViewController.swift
//  MinionTeam
//
//  Created by MacBook on 04.05.2022.
//

import UIKit
import Kingfisher

class PhotoCollectionViewController: UICollectionViewController {
    
    let cellsInRow = 2
    let offset: CGFloat = 2.0
    
    let reuseIdentifierPhotoCell = "reuseIdentifierPhotoCell"
    let fullScreenSegue = "fullScreenSegue"
    
    var selectedFriend: Friend?
    
    var photoImageView: UIImageView!
    var friendPhotos: [Photo] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    var friendImages: [UIImage] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        collectionView.register(UINib(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifierPhotoCell)
                
        title = selectedFriend?.name
        
        ServiceVK().loadPhotos(for: selectedFriend!.userID) { friendPhotos in
            self.friendPhotos = friendPhotos
            self.fillFriendImagesArray(photos: friendPhotos)
        }
    }
    
    func fillFriendImagesArray(photos: [Photo]) {
        for photo in photos {
            let url = URL(string: photo.collectionPhotoData)
            let resource = ImageResource(downloadURL: url!)

            KingfisherManager.shared.retrieveImage(with: resource) { result in
                switch result {
                case .success(let value):
                    self.friendImages.append(value.image)
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friendPhotos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierPhotoCell, for: indexPath) as? CustomCollectionViewCell else {preconditionFailure("Error")}
        
        cell.configure(photo: friendPhotos[indexPath.item])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "FullScreenVC") as? FullScreenVC else {return}
        vc.selectedPhotoData = friendPhotos[indexPath.item].collectionPhotoData
        vc.selectedPhotoIndex = indexPath.item
        vc.photos = friendPhotos
        vc.friendImages = friendImages
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
