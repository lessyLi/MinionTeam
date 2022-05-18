//
//  CustomTableViewCell.swift
//  MinionTeam
//
//  Created by MacBook on 13.05.2022.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    
    
    override func prepareForReuse() {
        avatarImageView.image = nil
        titleLabel.text = nil
    }
    
    func configure(friend: Friend) {
        avatarImageView.image = friend.avatar
        titleLabel.text = friend.name
    }
    
    func configure(group: Group) {
        avatarImageView.image = group.avatar
        titleLabel.text = group.name
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        avatarImageView.layer.cornerRadius = 61
//        avatarImageView.layer.borderWidth = 0.5
//        avatarImageView.layer.borderColor = UIColor.gray.cgColor
        backView.layer.cornerRadius = 61
        backView.layer.shadowColor = UIColor.black.cgColor
        backView.layer.shadowOffset = CGSize(width: 10, height: 10)
        backView.layer.shadowRadius = 10
        backView.layer.shadowOpacity = 0.5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
