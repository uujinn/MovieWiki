//
//  ReviewCell.swift
//  MovieWiki
//
//  Created by 양유진 on 2021/10/13.
//

import UIKit

class ReviewCell: UITableViewCell {

    @IBOutlet weak var reviewImg: UIImageView!
    @IBOutlet weak var reviewRating: UILabel!
    @IBOutlet weak var reviewTitle: UILabel!
    @IBOutlet weak var reviewText: UILabel!
    
    let movieModel = MovieModel.shared
    
    var index = 0
    var delegate: removeDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func toRemove(_ sender: Any) {
        self.delegate?.selectedInfoBtn(index: index)
    }
}
