//
//  LikeCounterView.swift
//  MinionTeam
//
//  Created by MacBook on 16.05.2022.
//

import UIKit

@IBDesignable class LikeCounterView: UIView {
    
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var likeCounterLabel: UILabel!
    
    @IBInspectable var heartsCount: Int = 0
    var isLiked = false

    private var view: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func loadFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "LikeCounterView", bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {return UIView()}
        return view
    }
    
    private func setup() {
        view = loadFromNib()
        guard let view = view else {return}
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        likeCounterLabel.text = String(heartsCount)
    }
    
    @IBAction func pressedHeartButton(_ sender: UIButton) {
        let button = sender
        if isLiked {
            button.setImage(UIImage(systemName: "heart"), for: .normal)
            heartsCount -= 1
            likeCounterLabel.text = String(heartsCount)
        } else {
            button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            heartsCount += 1
            likeCounterLabel.text = String(heartsCount)
        }
        isLiked = !isLiked
        
    }
}
