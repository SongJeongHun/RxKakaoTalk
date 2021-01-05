//
//  FriendsListViewModel.swift
//  RxKakaoTalk
//
//  Created by 송정훈 on 2021/01/05.
//

import Foundation
import RxSwift
import KakaoSDKAuth
import RxKakaoSDKAuth
import NSObject_Rx
import KakaoSDKTalk
import RxKakaoSDKTalk
class MainViewModel:ViewModelType{
    private lazy var myProfile = PublishSubject<TalkProfile>()
    lazy var friendsList = PublishSubject<[Friend]>()
    lazy var thumbNail = PublishSubject<[URL?]>()
    func getProfile(){
        TalkApi.shared.rx.profile()
            .retryWhen(Auth.shared.rx.incrementalAuthorizationRequired())
            .subscribe (onSuccess:{ (profile) in
                self.myProfile.onNext(profile)
            }, onError: {error in
                print(error)
            })
            .disposed(by: rx.disposeBag)
        
    }
    func getFriendsList(){
        TalkApi.shared.rx.friends()
            .retryWhen(Auth.shared.rx.incrementalAuthorizationRequired())
            .subscribe (onSuccess:{ (friends) in
                if let friend = friends.elements{
                    self.friendsList.onNext(friend)
                   
                }
            }, onError: {error in
                print(error)
            })
            .disposed(by: rx.disposeBag)
    }

   
    
}
