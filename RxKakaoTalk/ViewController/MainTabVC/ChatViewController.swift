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
        tableView.reloadData()
        super.viewWillAppear(animated)
    }
    override func viewDidLoad() {
        viewModel.getFriendsList()
            .concat(viewModel.getMyID())
            .subscribe(onCompleted: {
                self.socketConnecting()
            })
        tableView.separatorStyle = .none
        super.viewDidLoad()
    }
    func bindViewModel() {
        viewModel.friendsList
            .bind(to:tableView.rx.items(cellIdentifier: "chatCell",cellType: chatCell.self)){row,data,cell in
                cell.isOnline.tintColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
                cell.name.text = data.profileNickname
                guard let url = data.profileThumbnailImage else {
                    return cell.thumbNail.setImage(#imageLiteral(resourceName: "basic"), for: .normal)
                }
                let image = try! Data(contentsOf: url)
                cell.thumbNail.setImage(UIImage(data: image), for: .normal)
            }
            .disposed(by: rx.disposeBag)
        bindTapAction()
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
        // 필요한 소스
        // 1.친구목록 (viewModel.getFriendList())
        // 2.socket에서 불러온 ID리스트 (viewModel.getmyID())
        // 두개 모두 완료 한후 -> socketConnecting()
        self.viewModel.socketConnection()
            .subscribe(onNext:{ name in
                print("현재 모델----->\(self.viewModel.friendList)")
                if let index = (self.viewModel.friendList.firstIndex{ $0.id == Int(name)! }){
                    let indexPath = IndexPath(row: index, section: 0)
                    guard let cell = self.tableView.cellForRow(at: indexPath) as? chatCell else { return }
                    cell.isOnline.tintColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
                }
            })
            .disposed(by: self.rx.disposeBag)
    }
}
class chatCell:UITableViewCell{
    @IBOutlet weak var thumbNail:UIButton!
    @IBOutlet weak var name:UILabel!
    @IBOutlet weak var timeStamp:UILabel!
    @IBOutlet weak var content:UILabel!
    @IBOutlet weak var isOnline:UIImageView!
}
