//
//  ViewModelType.swift
//  RxKakaoTalk
//
//  Created by 송정훈 on 2021/01/05.
//
import Foundation
import RxSwift
import RxCocoa
class ViewModelType:NSObject{
    let sceneCoordinator:SceneCoordinatorType
    init(sceneCoordinator:SceneCoordinatorType){
        self.sceneCoordinator = sceneCoordinator
    }
}
