//
//  SocketManager.swift
//  RxKakaoTalk
//
//  Created by 송정훈 on 2021/01/08.
import Foundation
import SocketIO
import RxSwift
import UIKit
class SocketIOManager:NSObject{
    static let shared = SocketIOManager()
    override init() {
        super.init()
        socket = self.manager.socket(forNamespace: "/")
    }
    var manager = SocketManager(socketURL: URL(string: "http://169.254.206.102:3000")!)
    var socket : SocketIOClient!
    func establishConnection(){
        socket.connect()
    }
    func closeConnection(){
        socket.disconnect()
    }
    func connectToName(name:String) -> Observable<[Any]> {
        let subject = PublishSubject<[Any]>()
        socket.emit("connectUser",name)
        socket.on("userList"){data,_ in
            subject.onNext(data[0] as! [[String:Any]])
        }
        return subject
    }
}

