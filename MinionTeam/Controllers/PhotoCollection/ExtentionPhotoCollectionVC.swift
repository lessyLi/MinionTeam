//
//  ExtantionPhotoCollectionVC.swift
//  MinionTeam
//
//  Created by MacBook on 14.05.2022.
//

import Foundation
import UIKit

extension PhotoCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let collectionViewWidth = collectionView.frame.width
        let spacing = CGFloat(cellsInRow + 1) * offset
        let widthCell = collectionViewWidth / CGFloat(cellsInRow)
        let heightCell = widthCell
        
//        let collectionViewWidth = collectionView.bounds.width
//        let whiteSpace = CGFloat(10)
//        let lineCountCell = CGFloat(3)
//        let cellWidth = collectionViewWidth / lineCountCell - whiteSpace
        
        return CGSize(width: widthCell - spacing, height: heightCell - offset * 2)
    }
}
