//
//  MovieModel.swift
//  MovieWiki
//
//  Created by 양유진 on 2021/10/10.
//

import Foundation
import SwiftyJSON

class MovieModel: NSObject{
    static let shared = MovieModel()
    var popular: [JSON] = [] // 인기
    var nowPlaying: [JSON] = [] // 현재 상영 중
    var latest: [JSON] = []
    var index: Int = 0
}
