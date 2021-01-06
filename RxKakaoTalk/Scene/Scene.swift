//
//  Scene.swift
//  RxKakaoTalk
//
//  Created by 송정훈 on 2021/01/04.
//

import Foundation
import UIKit
enum Scene{
    case friendsList(MainViewModel)
    case login(LoginViewModel)
}
extension Scene{
    func instantiate(from storyboard:String = "Main") -> UIViewController{
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        switch self{
        case .friendsList(let mainviewModel):
            guard var mainVC = storyboard.instantiateViewController(identifier:"Main") as? UITabBarController else { fatalError() }
            guard var friendsVC = mainVC.viewControllers?.first as? FriendsViewController else { fatalError() }
            guard var chatVC = mainVC.viewControllers?.last as? ChatViewController else { fatalError() }
            chatVC.bind(viewModel: mainviewModel)
            friendsVC.bind(viewModel: mainviewModel)
            return mainVC
        case.login(let viewModel):
            guard var loginVC = storyboard.instantiateViewController(identifier: "Login") as? LoginViewController else { fatalError() }
            loginVC.bind(viewModel: viewModel)
            return loginVC
        }
    }
}
