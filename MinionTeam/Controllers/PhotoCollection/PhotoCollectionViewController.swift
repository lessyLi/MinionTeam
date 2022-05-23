//
//  PhotoCollectionViewController.swift
//  MinionTeam
//
//  Created by MacBook on 04.05.2022.
//

import UIKit

//private let reuseIdentifier = "Cell"

class PhotoCollectionViewController: UICollectionViewController {

    @IBOutlet weak var photo: UIImageView!
    
    let reuseIdentifierPhotoCell = "reuseIdentifierPhotoCell"
    
    var photos = [UIImage]()
    
    var selectedFriend: Friend?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        collectionView.register(UINib(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifierPhotoCell)

        title = selectedFriend?.name
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
    
}
