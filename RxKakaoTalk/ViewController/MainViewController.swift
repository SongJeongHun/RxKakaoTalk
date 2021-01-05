//
//  MainViewController.swift
//  RxKakaoTalk
//
//  Created by 송정훈 on 2021/01/05.
//

import UIKit

class MainViewController: UITabBarController,ViewModelBindableType {
    var viewModel : MainViewModel!
    @IBOutlet weak var tableView:UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func bindViewModel() {
        viewModel.getProfile()
        viewModel.getFriendsList()
        viewModel.friendsList
            .bind(to:tableView.rx.items(cellIdentifier: "FriendsCell",cellType: FriendsCell.self)){row,value,cell in
                cell.name.text = value.profileNickname
            }
            .disposed(by: rx.disposeBag)
    }
}
class FriendsCell:UITableViewCell{
    @IBOutlet weak var button:UIButton!
    @IBOutlet weak var name:UILabel!
    
}
