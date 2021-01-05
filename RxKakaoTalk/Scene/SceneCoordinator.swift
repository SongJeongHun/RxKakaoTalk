//
//  SceneCoordinator.swift
//  RxKakaoTalk
//
//  Created by 송정훈 on 2021/01/04.
//

import Foundation
import RxSwift
import RxCocoa
extension UIViewController{
    var sceneViewController:UIViewController{
        return self
    }
}
class SceneCoordinator:SceneCoordinatorType{
    private let bag = DisposeBag()
    private var window:UIWindow
    private var currentVC:UIViewController
    required init(window:UIWindow){
        self.window = window
        currentVC = window.rootViewController!
    }
    func transition(to scene: Scene, using style: TransitionStyle, animated: Bool) -> Completable {
        let subject = PublishSubject<Void>()
        let target = scene.instantiate()
        switch style{
        case .root:
            currentVC = target
            window.rootViewController = target
            subject.onCompleted()
//        case .modal:
//        case .push:

        }
        return subject.ignoreElements()
    }
    
    func close(animated: Bool) -> Completable {
        return Completable.create{[unowned self] com in
            if let presentingVC = self.currentVC.presentingViewController{
                self.currentVC.dismiss(animated: animated){
                    self.currentVC = presentingVC.sceneViewController
                    com(.completed)
                }
            }else{
                com(.error(TransitionError.unknown))
                return Disposables.create()
            }
            return Disposables.create()
        }
        
    }
    
    
}
