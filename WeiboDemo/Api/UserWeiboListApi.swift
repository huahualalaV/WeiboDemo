//
//  userWeiboList.swift
//  WeiboDemo
//
//  Created by yu.zhu1 on 2020/5/14.
//  Copyright © 2020 Zijie Jiang. All rights reserved.
//

import Foundation
import Alamofire


protocol UserWeiboListApiProtocol {
    func userWeiboList(completion: @escaping (Result<UserWeiboTimeLine, LoginManager.ApiError>) -> Void)
}
class UserWeiboListApi: UserWeiboListApiProtocol {
    let url = "https://api.weibo.com/2/statuses/user_timeline.json"
    let login = Login(access_token: LoginManager.accessToken ?? "", uid: LoginManager.userID ?? "")
    func userWeiboList(completion: @escaping (Result<UserWeiboTimeLine, LoginManager.ApiError>) -> Void) {
        AF.request(url, method: .get, parameters: login)
            .responseDecodable(of: UserWeiboTimeLine.self) { (response) in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(LoginManager.ApiError(error: "error", error_code: -1, error_description: error.localizedDescription)))
            }
        }
    }
}
