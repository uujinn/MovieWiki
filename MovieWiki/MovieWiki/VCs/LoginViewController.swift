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
import NaverThirdPartyLogin
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController {
    
    // 네이버 로그인
    let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
    
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
                
                // 사용자 정보 가져오기
                UserApi.shared.me() {(user, error) in
                    if let error = error {
                        print(error)
                    }
                    else {
                        print("me() success.")
                        print("user: \(user?.kakaoAccount?.profile?.nickname ?? "user")")
                        print("userImg: \(user?.kakaoAccount?.profile?.profileImageUrl)")
                        UserDefaults.standard.set(user?.kakaoAccount?.profile?.nickname, forKey: "name")
                        UserDefaults.standard.set(user?.kakaoAccount?.profile?.profileImageUrl, forKey: "img")
                    }
                }
                
                UserDefaultsKey.isLoggedIn = true
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabVC") as! TabViewController

                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
                //do something
                _ = oauthToken
            }
        }
        
        

    }
    
    @IBAction func naverLogin(_ sender: Any) {
        loginInstance?.delegate = self
        loginInstance?.requestThirdPartyLogin()
    }
    
    @IBAction func logout(_ sender: Any) {
        loginInstance?.requestDeleteToken()
    }
    
    private func getNaverInfo() {
        guard let isValidAccessToken = loginInstance?.isValidAccessTokenExpireTimeNow() else { return }
        
        if !isValidAccessToken {
            return
        }
        
        guard let tokenType = loginInstance?.tokenType else { return }
        guard let accessToken = loginInstance?.accessToken else { return }
        let urlStr = "https://openapi.naver.com/v1/nid/me"
        let url = URL(string: urlStr)!
        
        let authorization = "\(tokenType) \(accessToken)"
        
        let req = AF.request(url,
                             method: .get,
                             parameters: nil,
                             encoding: JSONEncoding.default,
                             headers: ["Authorization": authorization])
        
        req.responseJSON { response in
            guard let result = response.value as? [String: Any] else { return }
            guard let object = result["response"] as? [String: Any] else { return }
            guard let name = object["name"] as? String else { return }
            guard let profileImg = object["profile_image"] as? String else {return}
            
            print("name: \(name)")
            print("profileImg: \(profileImg)")
            
            UserDefaults.standard.set(name, forKey: "name")
            UserDefaults.standard.set(profileImg, forKey: "img")

        
        }
        
        
    }
    

}

extension LoginViewController: NaverThirdPartyLoginConnectionDelegate {

        // 로그인에 성공했을 경우 호출
        func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
            print("[Success] : Success Naver Login")
            UserDefaultsKey.isLoggedIn = true
            getNaverInfo()
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabVC") as! TabViewController

            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
            
        }
        
        // 접근 토큰 갱신
        func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
            
        }
        
        // 로그아웃 할 경우 호출(토큰 삭제)
        func oauth20ConnectionDidFinishDeleteToken() {
            loginInstance?.requestDeleteToken()
        }
        
        // 모든 Error
        func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
            print("[Error] :", error.localizedDescription)
        }
}

