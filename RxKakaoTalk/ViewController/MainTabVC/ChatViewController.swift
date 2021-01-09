//
//  ChatViewController.swift
//  RxKakaoTalk
//
//  Created by 송정훈 on 2021/01/05.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx
import Action
import KakaoSDKTalk
import RxKakaoSDKTalk
class ChatViewController: UIViewController,ViewModelBindableType {
    var viewModel:  MainViewModel!
    @IBOutlet weak var tableView:UITableView!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidLoad() {
        tableView.separatorStyle = .none
        super.viewDidLoad()
    }
    func bindViewModel() {
        print("chatview바인디")
        viewModel.friendsList
            .bind(to:tableView.rx.items(cellIdentifier: "chatCell",cellType: chatCell.self)){row,data,cell in
                print("끄기")
                cell.isOnline.isHidden = true
                cell.name.text = data.profileNickname
                guard let url = data.profileThumbnailImage else {
                    return cell.thumbNail.setImage(#imageLiteral(resourceName: "basic"), for: .normal)
                }
                let image = try! Data(contentsOf: url)
                cell.thumbNail.setImage(UIImage(data: image), for: .normal)
                cell.layer.cornerRadius = 30
            }
            .disposed(by: rx.disposeBag)
        bindTapAction()
        socketConnecting()
    }
    func bindTapAction(){
        Observable.zip(tableView.rx.modelSelected(Friend.self),tableView.rx.itemSelected)
            .do(onNext:{[unowned self]_,row in
                self.tableView.deselectRow(at: row, animated: false)
            })
            .map{$0.0}
            .bind(to:viewModel.chattingAction.inputs)
            .disposed(by: rx.disposeBag)
    }
    func socketConnecting(){
        var friendList:[Friend] = []
        print("friendsList구독시작")
        viewModel.friendsList
            .subscribe(onNext:{data in
                friendList = data
            },onCompleted: {
                self.viewModel.socketConnection()
                    .subscribe(onNext:{name in
                        if let index = (friendList.firstIndex{ $0.id == Int(name)! }){
                            let indexPath = IndexPath(row: index, section: 0)
                            guard let cell = self.tableView.cellForRow(at: indexPath) as? chatCell else { return }
                            cell.isOnline.isHidden = false
                        }
                    })
                    .disposed(by: self.rx.disposeBag)
                
            })
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
