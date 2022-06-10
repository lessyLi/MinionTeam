//
//  CustomCollectionViewCell.swift
//  MinionTeam
//
//  Created by MacBook on 14.05.2022.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var heartsCountLabel: UILabel!
    
    var isLiked = false
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        photoImageView.image = nil
        isLiked = false
        heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
    }
    
    func configure(image: UIImage) {
        photoImageView.image = image
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        photoImageView.layer.cornerRadius = 12
        backView.layer.cornerRadius = 12
//        backView.layer.shadowColor = UIColor.black.cgColor
//        backView.layer.shadowOffset = CGSize(width: 10, height: 10)
//        backView.layer.shadowRadius = 10
//        backView.layer.shadowOpacity = 0.5
    }

    @IBAction func pressedHeartButton(_ sender: UIButton) {
        let button = sender
        var heartsCount = 17
       
        if isLiked {
            button.setImage(UIImage(systemName: "heart"), for: .normal)
            UIView.transition(with: heartsCountLabel, duration: 0.5, options: .transitionCrossDissolve) {
                self.heartsCountLabel.text = String(heartsCount - 1)
                self.heartsCountLabel.textColor = .black
            }
        } else {
            button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            heartsCount += 1
            UIView.transition(with: heartsCountLabel, duration: 0.5, options: [.transitionCrossDissolve, .transitionFlipFromRight]) {
                self.heartsCountLabel.text = String(heartsCount + 1)
                self.heartsCountLabel.textColor = .systemRed
            }
        }
        isLiked = !isLiked
        
        heartsCountLabel.text = String(heartsCount)
    }
    
    
}
