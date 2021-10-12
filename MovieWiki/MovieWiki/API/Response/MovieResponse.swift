//
//  MovieRequest.swift
//  MovieWiki
//
//  Created by 양유진 on 2021/10/12.
//

import Foundation

// MARK: - Movie
struct MovieResponse: Codable {
    let adult: Bool?
    let backdropPath: String?
    let belongsToCollection: BelongsToCollection?
    let budget: Int?
    let genres: [Genre]?
    let homepage: String?
    let id: Int?
    let imdbID, originalLanguage, originalTitle, overview: String?
    let popularity: Double?
    let posterPath: String?
    let productionCompanies: [ProductionCompany]?
    let productionCountries: [ProductionCountry]?
    let releaseDate: String?
    let revenue, runtime: Int?
    let spokenLanguages: [SpokenLanguage]?
    let status, tagline, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case belongsToCollection = "belongs_to_collection"
        case budget, genres, homepage, id
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue, runtime
        case spokenLanguages = "spoken_languages"
        case status, tagline, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseBelongsToCollection { response in
//     if let belongsToCollection = response.result.value {
//       ...
//     }
//   }
// MARK: - BelongsToCollection
struct BelongsToCollection: Codable {
    let id: Int?
    let name, posterPath, backdropPath: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseGenre { response in
//     if let genre = response.result.value {
//       ...
//     }
//   }
// MARK: - Genre
struct Genre: Codable {
    let id: Int?
    let name: String?
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseProductionCompany { response in
//     if let productionCompany = response.result.value {
//       ...
//     }
//   }
// MARK: - ProductionCompany
struct ProductionCompany: Codable {
    let id: Int?
    let logoPath: String?
    let name, originCountry: String?

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseProductionCountry { response in
//     if let productionCountry = response.result.value {
//       ...
//     }
//   }
// MARK: - ProductionCountry
struct ProductionCountry: Codable {
    let iso3166_1, name: String?

    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseSpokenLanguage { response in
//     if let spokenLanguage = response.result.value {
//       ...
//     }
//   }
// MARK: - SpokenLanguage
struct SpokenLanguage: Codable {
    let englishName, iso639_1, name: String?

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso639_1 = "iso_639_1"
        case name
    }
}




//https://github.com/bipsa/Movies/blob/ecd29976184511e163a0c71469939207a97f939f/Movies/Classes/Api/TheMovieDB.swift
//https://github.com/StevenRock/MovieCheckList/blob/24885551d39f3e25d2b9b8cc68017be2df6062f6/MovieCheckList/Model/MovieData.swift
//https://github.com/Maksim-Lipenka/whatToWatch/blob/f81d10df9d5e64549702bedd772ccca36dadef01/whatToWatch/Models/MovieResponse.swift
//https://github.com/melisaozturk/MovieDBProgrammaticallyStoryboard/blob/211fcca5bb44649064db2a19d05c442cc5cfe07f/YemeksepetiMovieDB/Model/MovieDetailModel.swift
//https://github.com/bipsa/Movies/blob/ecd29976184511e163a0c71469939207a97f939f/Movies/Classes/Api/TheMovieDBStructures.swift
//https://github.com/PunitSV/Moviez/blob/2234350f11f90ce7d980cb90d0eb0dac1ac9d366/Moviez/Models/Movie.swift
