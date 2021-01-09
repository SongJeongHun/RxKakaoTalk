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
    var myID:String = ""
    var friendList:[Friend] = []
    var myProfile = PublishSubject<String>()
    var friendsList = PublishSubject<[Friend]>()
    var test = PublishSubject<String>()
    var mythumbNail = PublishSubject<URL?>()
    func getMyID() -> Completable{
        let subject = PublishSubject<Void>()
        UserApi.shared.rx.me()
            .subscribe(onSuccess:{ (data) in
                self.myID = String(data.id)
                print("id끝!")
                subject.onCompleted()
            })
        return subject.ignoreElements()
    }
    func getProfile() -> Completable{
        let subject = PublishSubject<Void>()
        TalkApi.shared.rx.profile()
            .retryWhen(Auth.shared.rx.incrementalAuthorizationRequired())
            .subscribe (onSuccess:{ (profile) in
                self.name = profile.nickname
                self.myProfile.onNext(profile.nickname)
                subject.onCompleted()
            }, onError: {error in
                subject.onError(error)
            })
        return subject.ignoreElements()

    }
    func getFriendsList() -> Completable{
        let subject = PublishSubject<Void>()
        TalkApi.shared.rx.friends()
            .retryWhen(Auth.shared.rx.incrementalAuthorizationRequired())
            .subscribe (onSuccess:{ (friends) in
                if let friend = friends.elements{
                    self.friendsList.onNext(friend)
                    self.friendList.append(contentsOf: friend)
                    self.test.onNext(String(friend.count))
                    print("리스트끝!")
                    subject.onCompleted()
                }
            }, onError: {error in
                subject.onError(error)
            })
        return subject.ignoreElements()
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
            print("소켓구독시작")
        SocketIOManager.shared.connectToName(name: self.myID)
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
        return stringSubject
    }
}
