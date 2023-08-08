//
//  SearchTableViewCell.swift
//  BookWormProject
//
//  Created by 김지연 on 2023/08/08.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    static let identifier = "SearchTableViewCell"
    
    
    @IBOutlet var bookImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.numberOfLines = 0
        titleLabel.font = .boldSystemFont(ofSize: 15)
        
        authorLabel.font = .systemFont(ofSize: 13)
        
        
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
}
