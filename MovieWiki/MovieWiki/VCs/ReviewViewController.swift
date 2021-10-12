//
//  ReviewViewController.swift
//  MovieWiki
//
//  Created by 양유진 on 2021/10/12.
//

import UIKit
import Cosmos
import Kingfisher

class ReviewViewController: UIViewController {

    @IBOutlet weak var cosmosView: CosmosView!
    
    @IBOutlet weak var posterImg: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var reviewMsg: UITextView!
    
    var movieTitle = ""
    var movieImgPath = ""
    
    let r = Review.shared
    
    override func viewWillAppear(_ animated: Bool) {
        self.movieTitleLabel.text = movieTitle
        self.posterImg.kf.setImage(with: URL(string: movieImgPath))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 별점
        cosmos()

    }

    override func viewWillDisappear(_ animated: Bool) {
//        print(r.reviewArray)
    }
    
    @IBAction func uploadReview(_ sender: Any) {
        r.reviewArray.append(reviewModel(movieTitle: movieTitle, movieImgPath: movieImgPath, rating: cosmosView.rating, reviewMsg: reviewMsg.text))
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
   

    func cosmos(){
        self.cosmosView.settings.updateOnTouch = true
        self.cosmosView.settings.fillMode = .half
        self.cosmosView.settings.starSize = 40
        self.cosmosView.settings.starMargin = 5
    }
}
