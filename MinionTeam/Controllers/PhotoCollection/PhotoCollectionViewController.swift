//
//  PhotoCollectionViewController.swift
//  MinionTeam
//
//  Created by MacBook on 04.05.2022.
//

import UIKit

class PhotoCollectionViewController: UICollectionViewController {
    
    let cellsInRow = 2
    let offset: CGFloat = 2.0
    
    let reuseIdentifierPhotoCell = "reuseIdentifierPhotoCell"
    let fullScreenSegue = "fullScreenSegue"
    
    var photoImageView: UIImageView!
    var photos: [UIImage] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    var selectedFriend: Friend?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        collectionView.register(UINib(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifierPhotoCell)
                
        title = selectedFriend?.name
        
        ServiceVK().loadVKData(method: .photos) { [weak self] photos in
            let photoArray = photos as? [Photo] ?? []
            for item in photoArray {
                self?.photos.append(item.photo)
            }
        }

    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierPhotoCell, for: indexPath) as? CustomCollectionViewCell else {preconditionFailure("Error")}
        
        cell.configure(image: photos[indexPath.item])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "FullScreenVC") as? FullScreenVC else {return}
        vc.selectedPhoto = photos[indexPath.item]
        vc.selectedPhotoIndex = indexPath.item
        vc.photos = photos
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
