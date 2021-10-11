//
//  TableViewTitleCell.swift
//  MovieWiki
//
//  Created by 양유진 on 2021/10/10.
//

import UIKit
import MSPeekCollectionViewDelegateImplementation
import SwiftyJSON
import Alamofire
import Kingfisher

protocol CollectionViewCellDelegate: AnyObject{
    func collectionView(collectionviewcell: MovieCell?, index: Int, didTappedInTableViewCell: TableViewTitleCell)
}

class TableViewTitleCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let behavior = MSCollectionViewPeekingBehavior()
    let movieModel = MovieModel.shared
    
    weak var cellDelegate: CollectionViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        let cellNib = UINib(nibName: "MovieCell", bundle: nil)
        self.collectionView.register(cellNib, forCellWithReuseIdentifier: "MovieCell")
        
        behavior.cellSpacing = 8
        behavior.cellPeekWidth = 18
        behavior.numberOfItemsToShow = 2
        collectionView.configureForPeekingBehavior(behavior: behavior)
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}

extension TableViewTitleCell: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieModel.popular.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MovieCell{
            
            let url = "https://image.tmdb.org/t/p/original"
            if (titleLabel.text == "인기"){ // popular
                cell.movieImage.kf.setImage(with: URL(string: url + movieModel.popular[indexPath[1]]["poster_path"].stringValue))
                cell.movieLabel.text = movieModel.popular[indexPath.row]["title"].stringValue
//                print(movieModel.popular[indexPath.row])
            }else if (titleLabel.text == "현재 상영 중"){ // nowPlaying
                cell.movieImage.kf.setImage(with: URL(string: url + movieModel.nowPlaying[indexPath[1]]["poster_path"].stringValue))
                cell.movieLabel.text = movieModel.nowPlaying[indexPath.row]["title"].stringValue
            }else if (titleLabel.text == "최신 개봉작"){ // latest
                cell.movieImage.kf.setImage(with: URL(string: url + movieModel.latest[indexPath[1]]["poster_path"].stringValue))
                cell.movieLabel.text = movieModel.latest[indexPath.row]["title"].stringValue
            }
            
            cell.movieImage.layer.cornerRadius = 10
            
            return cell
        }
    
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("콜렉션 뷰: " + String(indexPath.row))
        
        let cell = collectionView.cellForItem(at: indexPath) as? MovieCell
        
        self.cellDelegate?.collectionView(collectionviewcell: cell, index: indexPath.item, didTappedInTableViewCell: self)
    }
    
    // 사용자가 스크롤을 하고 스크린과 손이 떨어졌을 때 호출
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        // content의 위치를 조정하여 페이징
        behavior.scrollViewWillEndDragging(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
    }
    
}
