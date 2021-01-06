//
//  ChatViewController.swift
//  RxKakaoTalk
//
//  Created by 송정훈 on 2021/01/05.
//

import UIKit

class ChatViewController: UIViewController,ViewModelBindableType {
    var viewModel:  MainViewModel!
    @IBOutlet weak var tableView:UITableView!
    override func viewDidLoad() {
        tableView.separatorStyle = .none
        super.viewDidLoad()
    }
    func bindViewModel() {
        viewModel.friendsList
            .bind(to:tableView.rx.items(cellIdentifier: "chatCell",cellType: chatCell.self)){row,data,cell in
                cell.name.text = data.profileNickname
                guard let url = data.profileThumbnailImage else {
                   return cell.thumbNail.setImage(#imageLiteral(resourceName: "basic"), for: .normal)
                }
                let image = try! Data(contentsOf: url)
                cell.thumbNail.setImage(UIImage(data: image), for: .normal)
            }
            .disposed(by: rx.disposeBag)
    }
}
class chatCell:UITableViewCell{
    @IBOutlet weak var thumbNail:UIButton!
    @IBOutlet weak var name:UILabel!
    @IBOutlet weak var timeStamp:UILabel!
    @IBOutlet weak var content:UILabel!
    @IBOutlet weak var isOnline:UIImageView!
}
