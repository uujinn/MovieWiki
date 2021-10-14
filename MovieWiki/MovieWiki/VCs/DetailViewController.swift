//
//  DetailViewController.swift
//  MovieWiki
//
//  Created by 양유진 on 2021/10/12.
//

import UIKit
import Alamofire
import Kingfisher

class DetailViewController: UIViewController {

    var movieId = 482373
    let movieModel = MovieModel.shared
    let imgurl = "https://image.tmdb.org/t/p/original"
    var poster_path = ""
    @IBOutlet weak var backImg: UIImageView!
    @IBOutlet weak var posterImg: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var releasedCountry: UILabel!
    @IBOutlet weak var movieInfo: UITextView!
    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var reviewBtn: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        MovieRequest().getMovieData(self, id: movieId)

    }
    
    @IBAction func createReview(_ sender: Any) {
        
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReviewVC") as? ReviewViewController else { return }

        vc.movieTitle = movieTitle.text!
        vc.movieImgPath = poster_path
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
        
//        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReviewVC") as? ReviewViewController else { return }
//        
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func goBackToHome(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

//MARK:- API
extension DetailViewController{
    func didSuccess(_ response: MovieResponse) {
        if response.posterPath != nil{
            self.posterImg.kf.setImage(with: URL(string: imgurl + response.posterPath!))
            poster_path = imgurl + response.posterPath!
        }
        if response.backdropPath != nil{
            self.backImg.kf.setImage(with: URL(string: imgurl + response.backdropPath!))
        }
        self.movieTitle.text = response.title
        self.releaseDate.text = response.releaseDate
        if response.productionCountries?.count != 0 {
            self.releasedCountry.text = response.productionCountries?[0].name
        }
        if response.genres?.count != 0{
            self.movieGenre.text = response.genres![0].name
        }
        self.movieInfo.text = response.overview
    }
}
