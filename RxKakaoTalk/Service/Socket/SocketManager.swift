//
//  SocketManager.swift
//  RxKakaoTalk
//
//  Created by 송정훈 on 2021/01/08.
import Foundation
import SocketIO
import UIKit
class SocketIOManager:NSObject{
    static let shared = SocketIOManager()
    override init() {
        super.init()
        socket = self.manager.socket(forNamespace: "")
    }
    var manager = SocketManager(socketURL: URL(string: "http://169.254.161.191:3000")!)
    var socket : SocketIOClient!
    func establishConnection(){
        socket.connect()
    }
    func closeConnection(){
        socket.disconnect()
    }
}
