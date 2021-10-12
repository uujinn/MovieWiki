//
//  MovieRequest.swift
//  MovieWiki
//
//  Created by 양유진 on 2021/10/12.
//

import UIKit
import Alamofire

class MovieRequest{
    
    func getMovieData(_ viewController: DetailViewController, id: Int){
        print("getMovieData - id: \(id)") //580489
        let url = "https://api.themoviedb.org/3/movie/\(id)?api_key=c54f2606f5cf4a0e9fd4dd02d158bf13&language=ko-KR"
        
        let params: Parameters = [
            "api_key": "c54f2606f5cf4a0e9fd4dd02d158bf13",
            "language": "ko-KR"
        ]
        
        // HTTP Method: GET
        AF.request(url,
                   method: .get,
                   parameters: params,
                   headers: nil)
            .responseDecodable(of: MovieResponse.self) { response in
                
                switch response.result {
                
                case .success(let response):
                    print("DEBUG>> TMDB Response \(response) ")
                    viewController.didSuccess(response)
                    
                case .failure(let error):
                    print("DEBUG>> TMDB Get Error : \(error.localizedDescription)")
                    
                }
            }
        
    }

}
