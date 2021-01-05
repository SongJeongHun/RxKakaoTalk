//
//  LoginViewModel.swift
//  RxKakaoTalk
//
//  Created by 송정훈 on 2021/01/04.
//

import Foundation
import RxSwift
import Action
import RxKakaoSDKAuth
import RxKakaoSDKUser
import KakaoSDKAuth
import KakaoSDKUser
class LoginViewModel:ViewModelType{
    func loginAction() -> CocoaAction{
        return CocoaAction{_ in
            if(AuthApi.isKakaoTalkLoginAvailable()){
                AuthApi.shared.rx.loginWithKakaoAccount()
                    .subscribe(onNext:{token in
                        let mainVM = MainViewModel(sceneCoordinator: self.sceneCoordinator)
                        let mainScene = Scene.friendsList(mainVM)
                        self.sceneCoordinator.transition(to: mainScene, using: .root, animated: true)
                    })
                    .disposed(by:self.rx.disposeBag)
            }
//            self.userInfo()
            return Observable.empty()
        }
    }
}
