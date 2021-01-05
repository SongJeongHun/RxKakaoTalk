//
//  ViewController.swift
//  RxKakaoTalk
//
//  Created by 송정훈 on 2021/01/04.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx
import Action
class LoginViewController: UIViewController,ViewModelBindableType {
    var viewModel :LoginViewModel!
    @IBOutlet weak var loginButton:UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func bindViewModel() {
        loginButton.rx.action = viewModel.loginAction()
    }
}

