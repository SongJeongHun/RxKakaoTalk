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
class LoginViewModel{
    let bag = DisposeBag()
    func loginAction() -> CocoaAction{
        return CocoaAction{_ in
            if(AuthApi.isKakaoTalkLoginAvailable()){
                AuthApi.shared.rx.loginWithKakaoTalk()
                    .subscribe(onNext:{token in
                        print(token)
                    },onError: {error in
                        print(error)
                    },onCompleted: {
                        print("completed")
                    })
                    .disposed(by: self.bag)
            }
            return Observable.empty()
        }
        
    }
    
}
