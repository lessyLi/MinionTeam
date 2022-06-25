//
//  CustomTableViewCell.swift
//  MinionTeam
//
//  Created by MacBook on 13.05.2022.
//

import UIKit
import Kingfisher

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.kf.cancelDownloadTask()
        avatarImageView.image = nil
        titleLabel.text = nil
    }
    
    func configure(friend: Friend) {
        let url = URL(string: friend.userPhotoData)
        avatarImageView.kf.setImage(with: url)
//        avatarImageView.image = friend.avatar
        titleLabel.text = friend.name + " " + friend.lastName
    }
    
    func configure(group: Group) {
        let url = URL(string: group.groupPhotoData)
        avatarImageView.kf.setImage(with: url)
//        avatarImageView.image = group.avatar
        titleLabel.text = group.name
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        avatarImageView.layer.cornerRadius = 61
        backView.layer.cornerRadius = 61
        backView.layer.shadowColor = UIColor.black.cgColor
        backView.layer.shadowOffset = CGSize(width: 10, height: 10)
        backView.layer.shadowRadius = 10
        backView.layer.shadowOpacity = 0.5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func animatePressingButton(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.5, options: .curveEaseInOut) {
            self.backView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.backView.transform = .identity
        } completion: { _ in
            let storybord = UIStoryboard(name: "Main", bundle: nil)
            let vc = storybord.instantiateViewController(withIdentifier: "PhotoCollectionViewController") as! PhotoCollectionViewController
            let navigationController = UINavigationController()
            navigationController.pushViewController(vc, animated: true)
            
        }

    }
    
}
