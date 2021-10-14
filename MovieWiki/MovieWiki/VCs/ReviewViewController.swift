//
//  ReviewViewController.swift
//  MovieWiki
//
//  Created by 양유진 on 2021/10/12.
//

import UIKit
import Cosmos
import Kingfisher

class ReviewViewController: UIViewController, UITextViewDelegate {

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
        
        reviewMsg.layer.cornerRadius = 10
        placeholderSetting()
        // 텍스트뷰 Padding
        reviewMsg.textContainerInset = UIEdgeInsets(top: 25, left: 15, bottom: 15, right: 15);
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
   
    // Placeholder 설정
    func placeholderSetting() {

        reviewMsg.delegate = self
        reviewMsg.text = "리뷰를 작성해주세요."
        reviewMsg.textColor = UIColor.lightGray

    }
    
    
    // TextView Place Holder
    func textViewDidBeginEditing(_ textView: UITextView) {

        if reviewMsg.textColor == UIColor.lightGray {
            reviewMsg.text = nil
            reviewMsg.textColor = UIColor.white
        }

    }
    
    // TextView Place Holder
    func textViewDidEndEditing(_ textView: UITextView) {

        if reviewMsg.text.isEmpty {
            reviewMsg.text = "리뷰를 작성해주세요."
            reviewMsg.textColor = UIColor.lightGray
        }

    }

    func makeSpace(tf: UITextView){
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 7
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 18, weight: .regular),
            .foregroundColor: UIColor.lightGray,
            .paragraphStyle: style
        ]
        tf.attributedText = NSAttributedString(string: reviewMsg.text, attributes: attributes)
    }
    
    func cosmos(){
        self.cosmosView.settings.updateOnTouch = true
        self.cosmosView.settings.fillMode = .half
        self.cosmosView.settings.starSize = 45
    }
    
    
}
