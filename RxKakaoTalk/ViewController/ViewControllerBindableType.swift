//
//  ViewModelBindableType.swift
//  RxJHMeMO
//
//  Created by 송정훈 on 2020/12/28.
//

import UIKit
protocol ViewModelBindableType {
    associatedtype ViewModelType    //typealias  가변타입
    var viewModel:ViewModelType!{get set}
    func bindViewModel()
}
extension ViewModelBindableType where Self: UIViewController {
    mutating func bind(viewModel:Self.ViewModelType){
        self.viewModel = viewModel
        loadViewIfNeeded()
        bindViewModel()
    }
}

