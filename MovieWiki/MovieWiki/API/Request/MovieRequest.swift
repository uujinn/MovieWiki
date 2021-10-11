//
//  MovieRequest.swift
//  MovieWiki
//
//  Created by 양유진 on 2021/10/12.
//

import Foundation

struct MovieItem:Decodable {
    let vote_count:Int32
    let id:Int32
    let video:Bool
    let vote_average:Double
    let title:String
    let popularity:Double
    let poster_path:String
    let original_language:String
    let original_title:String
    let genre_ids:[Int32] = []
    let backdrop_path:String?
    let adult:Bool
    let overview:String
    let release_date:String
}


struct MovieGenre:Decodable {
    let id:Int32
    let name:String
}


struct ProductionCompanies:Decodable {
    let id:Int32
    let name:String
    let logo_path:String?
    let origin_country:String
}


struct MovieDetail:Decodable {
    let budget:Double
    let genres:[MovieGenre]
    let homepage:String
    let imdb_id:String
    let production_companies:[ProductionCompanies]
    let revenue:Double
    let tagline:String
    let status:String
    let runtime:Double
}


struct MovieCast:Decodable {
    let cast_id:Int32
    let character:String
    let credit_id:String
    let gender:Int
    let id:Int32
    let name:String
    let profile_path:String?
}


struct MovieCrew:Decodable {
    let department:String
    let credit_id:String
    let job:String
    let name:String
    let gender:Int
    let profile_path:String?
}


struct MovieCredits:Decodable {
    let cast:[MovieCast]
    let crew:[MovieCrew]
}

//https://github.com/bipsa/Movies/blob/ecd29976184511e163a0c71469939207a97f939f/Movies/Classes/Api/TheMovieDB.swift
//https://github.com/StevenRock/MovieCheckList/blob/24885551d39f3e25d2b9b8cc68017be2df6062f6/MovieCheckList/Model/MovieData.swift
//https://github.com/Maksim-Lipenka/whatToWatch/blob/f81d10df9d5e64549702bedd772ccca36dadef01/whatToWatch/Models/MovieResponse.swift
//https://github.com/melisaozturk/MovieDBProgrammaticallyStoryboard/blob/211fcca5bb44649064db2a19d05c442cc5cfe07f/YemeksepetiMovieDB/Model/MovieDetailModel.swift
//https://github.com/bipsa/Movies/blob/ecd29976184511e163a0c71469939207a97f939f/Movies/Classes/Api/TheMovieDBStructures.swift
