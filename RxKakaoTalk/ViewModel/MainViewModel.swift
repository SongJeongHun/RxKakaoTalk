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
import Action
import KakaoSDKTalk
import RxKakaoSDKTalk
class MainViewModel:ViewModelType{
    lazy var myProfile = PublishSubject<String>()
    lazy var friendsList = PublishSubject<[Friend]>()
    lazy var test = PublishSubject<String>()
    lazy var mythumbNail = PublishSubject<URL?>()
    func getProfile(){
        TalkApi.shared.rx.profile()
            .retryWhen(Auth.shared.rx.incrementalAuthorizationRequired())
            .subscribe (onSuccess:{ (profile) in
                self.myProfile.onNext(profile.nickname)
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
                    self.test.onNext(String(friend.count))
                }
            }, onError: {error in
                print(error)
            })
            .disposed(by: rx.disposeBag)
    }
    lazy var chattingAction:Action<Friend,Void> = {
        print("chattingActionchattingActionchattingAction")
        return Action { friend in
            let chattingViewModel = ChattingViewModel(friend: friend, sceneCoordinator: self.sceneCoordinator)
            let chattingScene = Scene.chat(chattingViewModel)
            return self.sceneCoordinator.transition(to: chattingScene, using: .push, animated: true).asObservable().map{_ in }
        }
    }()
}
