//
//  FullScreenVC.swift
//  MinionTeam
//
//  Created by MacBook on 28.05.2022.
//

import UIKit
import Kingfisher
import RealmSwift

class FullScreenVC: UIViewController {

    @IBOutlet var fullScreenImageView: UIImageView!
    
    var selectedPhotoData: String!
//    var selectedPhoto: UIImage!
    var selectedPhotoIndex: Int!
    var photos = [Photo]()
    
    private var isLeftSwipe = false
    private var isRightSwipe = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        fullScreenImageView.image = selectedPhoto
        configureScreen(photoData: selectedPhotoData)
                
        let swipe = UIPanGestureRecognizer(target: self, action: #selector(swipePhoto(_ :)))
        fullScreenImageView.addGestureRecognizer(swipe)
        fullScreenImageView.isUserInteractionEnabled = true
    }
    
    func configureScreen(photoData: String) {
        let url = URL(string: photoData)
        fullScreenImageView.kf.setImage(with: url)
    }
    
    @objc func swipePhoto(_ recognizer: UIPanGestureRecognizer) {

        switch recognizer.state {

        case .began:

            isLeftSwipe = false
            isRightSwipe = false

            print("began")

        case .changed:
            let translation = recognizer.translation(in: self.view)

            if translation.x < 0 {
                isLeftSwipe = true
            } else {
                isRightSwipe = true
            }
            print("changed")

        case .ended:
            if isLeftSwipe {
                if selectedPhotoIndex < photos.count - 1 {
                    UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn) {
                        self.fullScreenImageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                        self.fullScreenImageView.alpha = 0
                    } completion: { _ in
                        self.configureScreen(photoData: self.photos[self.selectedPhotoIndex + 1].photoDict["x"] ?? "")
                        self.selectedPhotoIndex += 1
                        UIView.animate(withDuration: 0.4, delay: 0.1, options: .curveEaseOut) {
                            self.fullScreenImageView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                            self.fullScreenImageView.center.x -= self.view.frame.size.width
                            self.fullScreenImageView.alpha = 1
                        } completion: { _ in }
                    }
                }
            } else {
                if selectedPhotoIndex > 0 {
                    UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn) {
                        self.fullScreenImageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                        self.fullScreenImageView.alpha = 0
                    } completion: { _ in
                        self.configureScreen(photoData: self.photos[self.selectedPhotoIndex - 1].photoDict["x"] ?? "")
                        self.selectedPhotoIndex -= 1
                        UIView.animate(withDuration: 0.4, delay: 0.1, options: .curveEaseOut) {
                            self.fullScreenImageView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                            self.fullScreenImageView.center.x += self.view.frame.size.width
                            self.fullScreenImageView.alpha = 1
                        } completion: { _ in }
                    }
                }
            }
            print("ended")
        default:
            print("default")
        }
    }

}
