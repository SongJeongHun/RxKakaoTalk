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
    @IBOutlet weak var myName:UILabel!
    @IBOutlet weak var mythumbnail:UIButton!
    @IBOutlet weak var friendsCount:UILabel!
    override func viewDidLoad() {
        print("로드->\(viewModel)")
        tableView.separatorStyle = .none
        super.viewDidLoad()
    }
    func bindViewModel() {
        viewModel.myProfile
            .bind(to:myName.rx.text)
            .disposed(by: rx.disposeBag)
        viewModel.test
            .subscribe(onNext:{text in
                self.friendsCount.text = "친구(\(text))"
            })
            .disposed(by: rx.disposeBag)
        print("바인딩")
        viewModel.friendsList
            .bind(to:tableView.rx.items(cellIdentifier: "FriendsCell",cellType: FriendsCell.self)){row,data,cell in
                cell.name.text = data.profileNickname
                guard let url = data.profileThumbnailImage else {
                    cell.button.layer.cornerRadius = 30
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

