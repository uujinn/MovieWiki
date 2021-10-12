//
//  ReviewModl.swift
//  MovieWiki
//
//  Created by 양유진 on 2021/10/13.
//

import Foundation
import UIKit

struct reviewModel{
    var movieTitle: String
    var movieImgPath: String
    var rating: Double
    var reviewMsg: String
}
class Review {
    static let shared = Review()
    var reviewArray: [reviewModel] = []
}
