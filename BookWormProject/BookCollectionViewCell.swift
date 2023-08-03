//
//  BookCollectionViewCell.swift
//  BookWormProject
//
//  Created by 김지연 on 2023/07/31.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {

    static let identifier = "BookCollectionViewCell"
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var likeButton: UIButton!
    
    func configCell(movie: Movie) {
        
        titleLabel.text = movie.title
        titleLabel.textColor = .white
        
        rateLabel.text = "\(movie.rate)"
        rateLabel.textColor = .white
        posterImageView.image = UIImage(named: movie.title)
        changeLikeButtonImage(like: movie.like)
        
        
        
    }
    
    func changeLikeButtonImage(like: Bool) {
        
        like == true ? likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal) : likeButton.setImage(UIImage(systemName: "heart"), for: .normal)

    }
    
    
}
