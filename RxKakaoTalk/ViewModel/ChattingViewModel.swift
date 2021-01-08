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
    let testMsg = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
    lazy var dummyList = [Message(sender: myName, content:testMsg , receiver: "\(friend.profileNickname)", timeStamp: "2021.1.8"),Message(sender: myName, content: "ㅇㅇ", receiver: "\(friend.profileNickname)", timeStamp: "2021.1.8"),Message(sender: "\(friend.profileNickname)", content: testMsg, receiver: "\(friend.profileNickname)", timeStamp: "2021.1.8")]
//    var contents:Observable<[Message]>!
    init(friend:Friend,sceneCoordinator:SceneCoordinatorType,myName:String){
        self.myName = myName
        self.friend = friend
        super.init(sceneCoordinator: sceneCoordinator)
    }
    func getChatList() -> Observable<[Message]>{
        return Observable.just(dummyList)
    }
    func isMine(at row:Int) -> Bool{
        if (dummyList[row].sender == myName){
            return true
        }
        return false
    }
}

