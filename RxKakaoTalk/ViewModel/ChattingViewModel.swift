//
//  ChattingViewModel.swift
//  RxKakaoTalk
//
//  Created by 송정훈 on 2021/01/06.
//

import Foundation
import KakaoSDKTalk
class ChattingViewModel:ViewModelType{
    let friend:Friend
    init(friend:Friend,sceneCoordinator:SceneCoordinatorType){
        self.friend = friend
        super.init(sceneCoordinator: sceneCoordinator)
    }
}
