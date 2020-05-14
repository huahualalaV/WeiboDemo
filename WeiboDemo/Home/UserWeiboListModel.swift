//
//  UserWeiboListModel.swift
//  WeiboDemo
//
//  Created by yu.zhu1 on 2020/5/14.
//  Copyright © 2020 Zijie Jiang. All rights reserved.
//

import Foundation
protocol UserWeiboListModelProtocol {
    var userWeiboContent: WeiboContent? { get }
    func loadData()
}

class UserWeiboListModel: UserWeiboListModelProtocol {
    unowned let viewController: HomeViewControllerProtocol
    
    init(viewController: HomeViewControllerProtocol) {
        self.viewController = viewController
    }
    
    var userWeiboListApi: UserWeiboListApiProtocol = UserWeiboListApi()
    
    var userWeiboContent: WeiboContent?
    
    func loadData() {
        userWeiboListApi.userWeiboList { [weak self] (result) in
            guard let self = self else { return }
//            self.viewController.stopPullToRefresh()
            
            switch result {
            case .success(let response):
                
                self.userWeiboContent = response
                self.viewController.showUserWeiboContent(model: response)
//                self.viewController.reloadTableView()
//                self.viewController.scrollToTop()
                
            case .failure(let error):
                return self.viewController.showAlert(message: error.message)
            }
        }
    }
}