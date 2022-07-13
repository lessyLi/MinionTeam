//
//  NewsTableViewCell.swift
//  MinionTeam
//
//  Created by MacBook on 22.05.2022.
//

import UIKit
import Kingfisher

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
    
    var likeCount: Int = 0
    var commentCount: Int = 0
    var shareCount: Int = 0
    
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
    func configure(news: News, groups: [Int: Group]) {
        
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "d MMM YYYY, HH:mm:ss"
        
        var groupID = 0
        if news.sourceID < 0 {
            groupID = news.sourceID * -1
        }
        
        guard let urlString = groups[groupID]?.groupPhotoData,
        let groupName = groups[groupID]?.name else { return }
        if let url = URL(string: urlString) {
            newsImage.kf.setImage(with: url)
        }
        newsTitle.text = groupName
        newsText.text = news.newsDescription

        likeCount = news.likesCount
        commentCount = news.commentsCount
        shareCount = news.repostsCount
        
        likeLabel.text = String(likeCount)
        commentLabel.text = String(commentCount)
        shareLabel.text = String(shareCount)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func pressedLikeButton(_ sender: UIButton) {
        let button = sender
        button.setImage(UIImage(systemName: "heart"), for: .normal)
//        var likeCount = 107
        
        if isLiked {
            likeLabel.font = .systemFont(ofSize: 14)
            
            UIView.transition(with: likeLabel, duration: 0.5, options: .transitionCrossDissolve) {
                self.likeLabel.text = String(self.likeCount - 1)
                self.likeLabel.textColor = .black
            }
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseInOut) {
                self.likeView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                self.likeView.backgroundColor = .secondarySystemBackground
                self.likeView.transform = .identity
            }
            
        } else {
            self.likeCount += 1
            likeLabel.font = .boldSystemFont(ofSize: 14)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.5, options: .curveEaseOut) {
                self.likeView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                self.likeView.backgroundColor = .systemYellow
            }
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.5, options: .autoreverse) {
                self.likeButton.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            }
            
            UIView.transition(with: likeLabel, duration: 0.5, options: .transitionCrossDissolve) {
                self.likeLabel.text = String(self.likeCount + 1)
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
