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
import RxKakaoSDKUser
import KakaoSDKUser
class MainViewModel:ViewModelType{
    var name :String = ""
    var myID = PublishSubject<String>()
    var myProfile = PublishSubject<String>()
    var friendsList = PublishSubject<[Friend]>()
    var test = PublishSubject<String>()
    var mythumbNail = PublishSubject<URL?>()
    func getMyID(){
        UserApi.shared.rx.me()
            .subscribe { (data) in
                self.myID.onNext(String(data.id))
            }
            .disposed(by: rx.disposeBag)
    }
    func getProfile(){
        TalkApi.shared.rx.profile()
            .retryWhen(Auth.shared.rx.incrementalAuthorizationRequired())
            .subscribe (onSuccess:{ (profile) in
                self.name = profile.nickname
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
                    self.friendsList.onCompleted()
                    print()
                }
            }, onError: {error in
                print(error)
            })
            .disposed(by: rx.disposeBag)
    }
    lazy var chattingAction:Action<Friend,Void> = {
        return Action { friend in
            let chattingViewModel = ChattingViewModel(friend: friend, sceneCoordinator: self.sceneCoordinator, myName: self.name)
            let chattingScene = Scene.chat(chattingViewModel)
            return self.sceneCoordinator.transition(to: chattingScene, using: .push, animated: true).asObservable().map{_ in }
        }
    }()
}
extension MainViewModel{
    func socketConnection() -> Observable<String>{
        let stringSubject = PublishSubject<String>()
        myID.subscribe(onNext:{myName in
            SocketIOManager.shared.connectToName(name: myName)
                .subscribe(onNext:{data in
                    print(data)
                    for userList in data{
                        let user = userList as! [String:Any]
                        if(user["isConnected"] as! Int == 1){
                            stringSubject.onNext(user["nickname"] as! String)
                        }
                    }
                })
                .disposed(by: self.rx.disposeBag)
        })
        .disposed(by: rx.disposeBag)
        return stringSubject
    }
}
