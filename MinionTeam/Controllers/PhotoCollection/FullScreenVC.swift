//
//  FullScreenVC.swift
//  MinionTeam
//
//  Created by MacBook on 28.05.2022.
//

import UIKit

class FullScreenVC: UIViewController {

    @IBOutlet var fullScreenImageView: UIImageView!
    
    var selectedPhoto: UIImage!
    var selectedPhotoIndex: Int!
    var photos = [UIImage]()
    
    private var isLeftSwipe = false
    private var isRightSwipe = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fullScreenImageView.image = selectedPhoto
        
        let swipe = UIPanGestureRecognizer(target: self, action: #selector(swipePhoto(_ :)))
        fullScreenImageView.addGestureRecognizer(swipe)
        fullScreenImageView.isUserInteractionEnabled = true
    }
    
    @objc func swipePhoto(_ recognizer: UIPanGestureRecognizer) {
        
        switch recognizer.state {
        
        case .began:
   
            isLeftSwipe = false
            isRightSwipe = false
            
            print("began")
            
        case .changed:
            let translation = recognizer.translation(in: self.view)
            print(translation)

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
                        self.fullScreenImageView.image = self.photos[self.selectedPhotoIndex + 1]
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
                        self.fullScreenImageView.image = self.photos[self.selectedPhotoIndex - 1]
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
