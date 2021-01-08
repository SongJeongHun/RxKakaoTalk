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
    lazy var dummyList = [Message(sender: "송정훈", content: "테스트!테스트!테스트!테스트!테스트!테스트!테스트!테스트!테스트!테!테스트!테스트!테!테스트!테스트!테!,테스트!테스트!테스트!테스트!테스트!테스트!테스트!테스트!테스트!테스트!테스트!테스트!", receiver: "\(friend.profileNickname)", timeStamp: "2021.1.8"),Message(sender: "송정훈", content: "ㅇㅇ", receiver: "\(friend.profileNickname)", timeStamp: "2021.1.8")]
//    var contents:Observable<[Message]>!
    init(friend:Friend,sceneCoordinator:SceneCoordinatorType){
        self.friend = friend
        super.init(sceneCoordinator: sceneCoordinator)
    }
    func getChatList() -> Observable<[Message]>{
        return Observable.just(dummyList)
    }
}

