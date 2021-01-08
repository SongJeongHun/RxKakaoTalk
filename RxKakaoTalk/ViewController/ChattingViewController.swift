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
    @IBOutlet weak var tableView:UITableView!
    override func viewDidLoad() {
        setTableView()
        super.viewDidLoad()
    }
    func setTableView(){
        tableView.rx.setDelegate(self)
            .disposed(by: rx.disposeBag)
        tableView.separatorStyle = .none
    }
    func bindViewModel() {
        Observable.just(viewModel.friend.profileNickname)
            .bind(to: navigationItem.rx.title)
            .disposed(by: rx.disposeBag)
        viewModel.getChatList()
            .bind(to:tableView.rx.items(cellIdentifier: "MyCell",cellType: MyCell.self)){row,data,cell in
                cell.content.text = data.content
                cell.content.layer.zPosition = 100
                cell.view.layer.zPosition = 0
                
            }
            .disposed(by: rx.disposeBag)
    }
}
extension ChattingViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
class MyCell:UITableViewCell{
    @IBOutlet weak var content:UILabel!
    @IBOutlet weak var view:UIView!
    override func awakeFromNib() {
        view.layer.cornerRadius = 10
        super.awakeFromNib()
    }
}

