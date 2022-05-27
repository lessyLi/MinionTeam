//
//  NewsTableViewCell.swift
//  MinionTeam
//
//  Created by MacBook on 22.05.2022.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet var newsTitle: UILabel!
    @IBOutlet var newsText: UITextView!
    @IBOutlet var newsImage: UIImageView!
    
    @IBOutlet var likeView: UIView!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var likeLabel: UILabel!
    var isLiked = false
    
    @IBOutlet var commentView: UIView!
    @IBOutlet var commentButton: UIButton!
    @IBOutlet var commentLabel: UILabel!
    
    @IBOutlet var shareView: UIView!
    @IBOutlet var shareButton: UIButton!
    @IBOutlet var shareLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsTitle.text = nil
        newsImage.image = nil
        isLiked = false
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func pressedLikeButton(_ sender: UIButton) {
        let button = sender
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        var likeCount = 107
        if isLiked {
            
            likeLabel.font = .systemFont(ofSize: 14)
            
            UIView.transition(with: likeLabel, duration: 0.5, options: .transitionCrossDissolve) {
                self.likeLabel.text = String(likeCount - 1)
                self.likeLabel.textColor = .black
            }
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseInOut) {
                self.likeView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                self.likeView.backgroundColor = .secondarySystemBackground
                self.likeView.transform = .identity
            } completion: { _ in
                
            }
        } else {
            likeCount += 1
            likeLabel.font = .boldSystemFont(ofSize: 14)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.5, options: .curveEaseOut) {
                self.likeView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                self.likeView.backgroundColor = .systemYellow
            }
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.5, options: .autoreverse) {
                self.likeButton.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            }
            
            UIView.transition(with: likeLabel, duration: 0.5, options: .transitionCrossDissolve) {
                self.likeLabel.text = String(likeCount + 1)
            }
            
            UIView.transition(with: likeView, duration: 0.5, options: .transitionCrossDissolve) {
                button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            }
            
            self.likeView.transform = .identity
            self.likeButton.transform = .identity

            
        }
        isLiked = !isLiked
        
        likeLabel.text = String(likeCount)
    }
    
}
