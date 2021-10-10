//
//  MovieCell.swift
//  MovieWiki
//
//  Created by 양유진 on 2021/10/10.
//

import UIKit


class MovieCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieLabel: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
}
