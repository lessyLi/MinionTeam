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
    
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var likeLabel: UILabel!
    var isLiked = false
    
    @IBOutlet var commentButton: UIButton!
    @IBOutlet var commentLabel: UILabel!
    
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
        var likeCount = 0
        if isLiked {
            button.setImage(UIImage(systemName: "heart"), for: .normal)
        } else {
            button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            likeCount += 1
        }
        isLiked = !isLiked
        
        likeLabel.text = String(likeCount)
    }
    
    
}
