//
//  ChattingViewController.swift
//  RxKakaoTalk
//
//  Created by 송정훈 on 2021/01/06.
//

import UIKit
import RxSwift
import RxCocoa
import KakaoSDKTalk
import Action
class ChattingViewController: UIViewController,ViewModelBindableType{
    var viewModel:ChattingViewModel!
    @IBOutlet weak var friendName:UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func bindViewModel() {
        Observable.just(viewModel.friend.profileNickname)
            .bind(to: navigationItem.rx.title)
            .disposed(by: rx.disposeBag)
    }
}
