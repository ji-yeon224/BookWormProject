//
//  MovieInfoTableViewCell.swift
//  BookWormProject
//
//  Created by 김지연 on 2023/08/02.
//

import UIKit

class MovieInfoTableViewCell: UITableViewCell {
    
    static let identifier = "MovieInfoTableViewCell"

    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var infoLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = .boldSystemFont(ofSize: 15)
        infoLabel.font = .systemFont(ofSize: 12)
    }
    
    func configurationCell(movie: Movie) {
        titleLabel.text = movie.title
        infoLabel.text = "\(movie.releaseDate) | \(movie.runtime)분"
        posterImageView.image = UIImage(named: movie.title)
    }

    
}
