//
//  SceneCoordinatorType.swift
//  RxKakaoTalk
//
//  Created by 송정훈 on 2021/01/04.
//

import Foundation
import RxSwift

protocol SceneCoordinatorType {
    @discardableResult
    func transition(to scene:Scene,using style:TransitionStyle,animated:Bool) -> Completable
    @discardableResult
    func close(animated:Bool) -> Completable

}
