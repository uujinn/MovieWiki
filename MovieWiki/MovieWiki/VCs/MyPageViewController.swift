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
    
    let r = Review.shared
    
    let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance()

    override func viewWillAppear(_ animated: Bool) {

        userLabel.text = UserDefaults.standard.string(forKey: "name")
        userImg.kf.setImage(with: UserDefaults.standard.url(forKey: "img"))
        
        tableView.estimatedRowHeight = 400
        setupTableView()
        tableView.reloadData()
        
        let header = UIView(frame: CGRect(x:0, y:0, width: view.frame.size.width, height: 50))
        header.backgroundColor = .black
        
        let headerLabel = UILabel(frame: header.bounds)
        headerLabel.text = "Review 목록(\(r.reviewArray.count))"
        headerLabel.textAlignment = .center
        header.addSubview(headerLabel)
        
        tableView.tableHeaderView = header
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.estimatedRowHeight = 500
        self.tableView.rowHeight = UITableView.automaticDimension
        
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

extension MyPageViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return r.reviewArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell") as? ReviewCell else{
            return UITableViewCell()
        }
        
        cell.reviewTitle.text = r.reviewArray[indexPath.row].movieTitle
        cell.reviewImg.kf.setImage(with: URL(string: r.reviewArray[indexPath.row].movieImgPath))
        cell.reviewText.text = r.reviewArray[indexPath.row].reviewMsg
        cell.reviewRating.text = String(r.reviewArray[indexPath.row].rating)
        
        print(r.reviewArray)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 250
//    }
    
    private func setupTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let cell = UINib(nibName: "ReviewCell", bundle: nil)
        self.tableView.register(cell, forCellReuseIdentifier: "ReviewCell")
    }
    
    

}
