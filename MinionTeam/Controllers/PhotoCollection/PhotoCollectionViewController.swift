//
//  PhotoCollectionViewController.swift
//  MinionTeam
//
//  Created by MacBook on 04.05.2022.
//

import UIKit
import Kingfisher
import RealmSwift

class PhotoCollectionViewController: UICollectionViewController {
    
    let cellsInRow = 2
    let offset: CGFloat = 2.0
    let serviceVK = ServiceVK()
    
    let reuseIdentifierPhotoCell = "reuseIdentifierPhotoCell"
    let fullScreenSegue = "fullScreenSegue"
    
    private var notificationToken: NotificationToken?
    
//    var selectedFriend: Friend?
    var friendID: Int = 0
    
    var photoImageView: UIImageView!
    var friendPhotos: [Photo] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    var photosData: Results<Photo>?
    
    // MARK: - Deinit
    deinit {
        notificationToken?.invalidate()
    }
    // MARK: - View Did Load

    override func viewDidLoad() {
        super.viewDidLoad()
            
//        guard let selectedFriend = selectedFriend else { return }
//        title = selectedFriend.name
//        friendID = selectedFriend.userID
        
//        ServiceVK().loadPhotos(for: selectedFriend!.userID) { friendPhotos in
//            self.friendPhotos = friendPhotos
//            self.fillFriendImagesArray(photos: friendPhotos)
//        }
        serviceVK.loadPhotos(method: .photos, for: friendID)
        getPhotosDataFromRealm()
        observePhotoData()
        
        collectionView.register(UINib(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifierPhotoCell)
        
//       ServiceVK().loadPhotos(for: selectedFriend!.userID) { [weak self] in
//           self?.getPhotosDataFromRealm()
//        }
        
    }
    
    private func getPhotosDataFromRealm() {
        do {
            let realm = try Realm()
            photosData = realm.objects(Photo.self)
            if let photosData = photosData {
                friendPhotos = Array(photosData)
            }
        } catch {
            print(error)
        }
    }
    private func observePhotoData() {
        notificationToken = photosData?.observe { [weak self] change in
            switch change {
            case .initial:
                self?.collectionView.reloadData()
            case let .update(_, deletions, insertions, modifications):
                self?.collectionView.performBatchUpdates {
                    self?.collectionView.deleteItems(at: deletions.map { IndexPath(item: $0, section: 0) })
                    self?.collectionView.insertItems(at: insertions.map { IndexPath(item: $0, section: 0)})
                    self?.collectionView.reloadItems(at: modifications.map { IndexPath(item: $0, section: 0)})
                }
                self?.collectionView.reloadData()
            case .error(let error):
                print(error)
            }
        }
    }
//    func fillFriendImagesArray(photos: [Photo]) {
//        for photo in photos {
//            let url = URL(string: photo.collectionPhotoData)
//            let resource = ImageResource(downloadURL: url!)
//
//            KingfisherManager.shared.retrieveImage(with: resource) { result in
//                switch result {
//                case .success(let value):
//                    self.friendImages.append(value.image)
//                case .failure(let error):
//                    print("Error: \(error)")
//                }
//            }
//        }
//    }
    
    // MARK: - UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return friendPhotos.count
        return photosData?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierPhotoCell, for: indexPath) as? CustomCollectionViewCell else {preconditionFailure("Error")}
        
//        cell.configure(photo: friendPhotos[indexPath.item])
        
        guard let photo: Photo = photosData?[indexPath.item] else { return cell }
        cell.configure(photo: photo)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "FullScreenVC") as? FullScreenVC else {return}
        guard let photosData = photosData else {
            return
        }

      //  vc.selectedPhotoData = friendPhotos[indexPath.item].photoDict["x"]
        vc.selectedPhotoData = photosData[indexPath.item].photoDict["x"]
        vc.selectedPhotoIndex = indexPath.item
        //vc.photos = friendPhotos
        vc.photos = Array(photosData)
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
