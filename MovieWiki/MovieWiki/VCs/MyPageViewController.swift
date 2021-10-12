//
//  MyPageViewController.swift
//  MovieWiki
//
//  Created by 양유진 on 2021/10/10.
//

import UIKit
import NaverThirdPartyLogin
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon
import Kingfisher

class MyPageViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    
    let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance()

    override func viewWillAppear(_ animated: Bool) {

        userLabel.text = UserDefaults.standard.string(forKey: "name")
        userImg.kf.setImage(with: UserDefaults.standard.url(forKey: "img"))
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logout(_ sender: Any) {
        loginInstance?.requestDeleteToken()
        
        UserApi.shared.logout {(error) in
            if let error = error {
                print(error)
            }
            else {
                print("unlink() success.")
            }
        }
        
        UserDefaultsKey.isLoggedIn = false
    }
    
}
