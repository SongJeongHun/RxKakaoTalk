//
//  TransitionStyle.swift
//  RxKakaoTalk
//
//  Created by 송정훈 on 2021/01/05.
//

import Foundation
enum TransitionStyle{
    case root
    case push
//    case modal
}
enum TransitionError:Error{
    case navigationControllerMissing
    case cannotPop
    case unknown
}
