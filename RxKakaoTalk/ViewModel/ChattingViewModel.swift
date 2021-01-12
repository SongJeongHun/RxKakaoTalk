//
//  ChattingViewModel.swift
//  RxKakaoTalk
//
//  Created by 송정훈 on 2021/01/06.
//

import Foundation
import KakaoSDKTalk
import RxSwift
import RxCocoa
import Action
class ChattingViewModel:ViewModelType{
    let friend:Friend
    let myName:String
    let myID:String
    var dummyList : [Message] = []
    lazy var store = BehaviorSubject<[Message]>(value: dummyList)
    //    var contents:Observable<[Message]>!
    init(friend:Friend,sceneCoordinator:SceneCoordinatorType,myName:String,myID:String){
        self.myName = myName
        self.friend = friend
        self.myID = myID
        super.init(sceneCoordinator: sceneCoordinator)
    }
    func isMine(at row:Int) -> Bool{
        if (dummyList[row].sender == myID){
            return true
        }
        return false
    }
    lazy var sendAction = Action<String,Void>{content in
        let message = Message(sender: self.myID, content: content, receiver: String(self.friend.id))
        SocketIOManager.shared.sendMessage(msg: message)
        return Observable.empty()
    }
    func listenMyMessage() -> Observable<[Message]>{
        let subject = BehaviorSubject<[Message]>(value: self.dummyList)
        SocketIOManager.shared.getMessage()
            .subscribe(onNext:{data in
                print(data)
                if data.sender == self.myID || data.receiver == self.myID{
                    self.dummyList.append(data)
                    subject.onNext(self.dummyList)
                }
            },onError: { error in
                subject.onError(error)
            })
            .disposed(by: rx.disposeBag)
        return subject
    }
}

