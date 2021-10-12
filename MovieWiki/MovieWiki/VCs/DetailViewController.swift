//
//  DetailViewController.swift
//  MovieWiki
//
//  Created by 양유진 on 2021/10/12.
//

import UIKit
import Alamofire

class DetailViewController: UIViewController {

    var movieId = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(movieId)
        MovieRequest().getMovieData(self)
    }
    
    @IBAction func goBackToHome(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

//MARK:- API
extension DetailViewController{
    func didSuccess(_ response: MovieResponse) {
        
        let movieMain = response.originalTitle
        
        print(movieMain)
    }
}
