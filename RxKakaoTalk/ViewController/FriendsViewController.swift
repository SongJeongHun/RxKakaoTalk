//
//  FriendsViewController.swift
//  RxKakaoTalk
//
//  Created by 송정훈 on 2021/01/05.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx
import Action
class FriendsViewController: UIViewController,ViewModelBindableType {
    var viewModel: MainViewModel!
    @IBOutlet weak var tableView:UITableView!
    override func viewDidLoad() {
        
        tableView.separatorStyle = .none
        super.viewDidLoad()
    }
    func bindViewModel() {
        viewModel.getFriendsList()
        viewModel.friendsList
            .observeOn(MainScheduler.instance)
            .bind(to:tableView.rx.items(cellIdentifier: "FriendsCell",cellType: FriendsCell.self)){row,data,cell in
                cell.name.text = data.profileNickname
                guard let url = data.profileThumbnailImage else {
                   return cell.button.setImage(#imageLiteral(resourceName: "basic"), for: .normal)
                }
                let image = try! Data(contentsOf: url)
                cell.button.setImage(UIImage(data: image), for: .normal)
            }
            .disposed(by: rx.disposeBag)
    }  
}
    class FriendsCell:UITableViewCell{
        @IBOutlet weak var button:UIButton!
        @IBOutlet weak var name:UILabel!
    }

