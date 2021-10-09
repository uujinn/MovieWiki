//
//  ViewController.swift
//  MovieWiki
//
//  Created by 양유진 on 2021/10/09.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func kakaoLogin(_ sender: Any) {
        // 카카오톡 설치 여부 확인
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    
                    //do something
                    _ = oauthToken
                }
            }
        }
        
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            if let error = error {
                print(error)
            }
            else {
                print("loginWithKakaoAccount() success.")
                
                //do something
                _ = oauthToken
            }
        }
        
        
        //        // 사용자 정보 가져오기
        //        UserApi.shared.me() {(user, error) in
        //            if let error = error {
        //                print(error)
        //            }
        //            else {
        //                print("me() success.")
        //                print("user: \(user?.kakaoAccount?.profile?.nickname ?? "user")")
        //                //do something
        //                _ = user
        //            }
        //        }
        
        //        UserApi.shared.logout {(error) in
        //            if let error = error {
        //                print(error)
        //            }
        //            else {
        //                print("unlink() success.")
        //            }
        //        }
    }
    
}

