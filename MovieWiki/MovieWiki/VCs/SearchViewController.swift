//
//  SearchViewController.swift
//  MovieWiki
//
//  Created by 양유진 on 2021/10/10.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class SearchViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchTextField: UITextField!
    
    private var arr: [JSON] = []
    var idx: Int = 0
    
    let url1 = "https://api.themoviedb.org/3/search/movie?api_key=c54f2606f5cf4a0e9fd4dd02d158bf13&query="
    let url2 = "&page=1"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self

        setupFlowLayout()
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCell", for: indexPath) as? SearchCell else{
            return UICollectionViewCell()
        }
        
        let arr = arr[indexPath.row]
        cell.movieLabel.text = arr["title"].stringValue
        cell.movieImage.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500" + arr["poster_path"].stringValue))
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let arr = arr[indexPath.row]
        idx = arr["id"].intValue
        print("selected: \(indexPath.row)")
    }
    @IBAction func pressedToSearch(_ sender: Any) {
        let searchText = searchTextField.text
        AF.request(url1 + searchText! + url2).responseJSON { response in
            if let value = response.value{
                let json = JSON(value)
                self.arr = json["results"].arrayValue
                self.idx = json["id"].intValue
                self.collectionView.reloadData()
            }
        }
    }
    
    private func setupFlowLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets.zero
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 10
        
        let halfWidth = UIScreen.main.bounds.width / 3
        flowLayout.itemSize = CGSize(width: halfWidth * 0.9, height: halfWidth * 1.5)
        self.collectionView.collectionViewLayout = flowLayout
    }
}

