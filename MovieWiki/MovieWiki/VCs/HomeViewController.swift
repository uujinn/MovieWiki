//
//  HomeViewController.swift
//  MovieWiki
//
//  Created by 양유진 on 2021/10/10.
//

import UIKit
import Alamofire
import Kingfisher
import SwiftyJSON

class HomeViewController: UIViewController, CollectionViewCellDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    private var arr : [JSON] = []
    
    let movieModel = MovieModel.shared
    
    let dispatchGroup = DispatchGroup()
    let queue = DispatchQueue(label: "queue", qos: .default, attributes: .concurrent)
    
    let url : [String] = ["https://api.themoviedb.org/3/movie/popular?api_key=c54f2606f5cf4a0e9fd4dd02d158bf13&language=ko-KR&page=1&region=KR", "https://api.themoviedb.org/3/movie/now_playing?api_key=c54f2606f5cf4a0e9fd4dd02d158bf13&language=ko-KR&page=1&region=KR", "https://api.themoviedb.org/3/movie/upcoming?api_key=c54f2606f5cf4a0e9fd4dd02d158bf13&language=ko-KR&page=1&region=KR"]
    
    let params: Parameters = [
        "api_key": "c54f2606f5cf4a0e9fd4dd02d158bf13",
        "language": "ko-KR",
        "page": "1"
    ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMovieList()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        setupTableView()

    }
    
    func collectionView(collectionviewcell: MovieCell?, index: Int, didTappedInTableViewCell: TableViewTitleCell) {
        
        let movieModel = MovieModel.shared
        movieModel.index = index
        print("index: \(index)")
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailVC") as? DetailViewController else { return }
        
        switch didTappedInTableViewCell.titleLabel.text{
        case "인기":
            movieModel.id = movieModel.popular[index]["id"].intValue
            break
        case "현재 상영 중":
            movieModel.id = movieModel.nowPlaying[index]["id"].intValue
            break
        case "최신 개봉작":
            movieModel.id = movieModel.latest[index]["id"].intValue
            break
        default:
            break
        }

        vc.movieId = movieModel.id
        print("HomeVC movieModel.id : \(movieModel.id)")
//        self.navigationController?.pushViewController(vc, animated: true)

        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
    
    func getMovieList(){

        DispatchQueue.global().async{
            AF.request(self.url[0]).responseJSON { [self] (response) in
                if let value = response.value{
                    let json = JSON(value)
                    arr = json["results"].arrayValue
                    movieModel.popular = arr
                }
            }
            
            AF.request(self.url[1]).responseJSON { [self] (response) in
                if let value = response.value{
                    let json = JSON(value)
                    arr = json["results"].arrayValue
                    movieModel.nowPlaying = arr
                }
            }
            
            AF.request(self.url[2]).responseJSON { [self] (response) in
                if let value = response.value{
                    let json = JSON(value)
                    arr = json["results"].arrayValue
                    movieModel.latest = arr
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        setupTableView()
                    }
                }
            }
        
        }
        
        

        
        
    }

}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewTitleCell") as? TableViewTitleCell else{
            return UITableViewCell()
        }
        
        switch indexPath.row {
        case 0:
            cell.titleLabel.text = "인기"
            break
        case 1:
            cell.titleLabel.text = "현재 상영 중"
            break
        case 2:
            cell.titleLabel.text = "최신 개봉작"
            break

        default:
            print("없음")
            break
        }

        cell.cellDelegate = self
        cell.setCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("선택된 행은 \(indexPath.row) 입니다.")
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 310
    }
    
    private func setupTableView(){
            // Register the xib for tableview cell
        tableView.delegate = self
        tableView.dataSource = self

        let cell = UINib(nibName: "TableViewTitleCell", bundle: nil)
        self.tableView.register(cell, forCellReuseIdentifier: "TableViewTitleCell")

    }
    
}

