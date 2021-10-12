//
//  UserModel.swift
//  MovieWiki
//
//  Created by 양유진 on 2021/10/13.
//

import Foundation

class UserDefaultsKey {
    
    static var isLoggedIn: Bool = UserDefaults.standard.bool(forKey: "Login") {
        didSet {
            UserDefaults.standard.setValue(isLoggedIn, forKey: "Login")
        }
    }

    static var name: String = UserDefaults.standard.string(forKey: "name")!
    static var imgPath: URL = UserDefaults.standard.url(forKey: "img")!
}
