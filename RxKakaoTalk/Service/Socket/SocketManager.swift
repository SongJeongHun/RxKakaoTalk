//
//  SocketManager.swift
//  RxKakaoTalk
//
//  Created by 송정훈 on 2021/01/08.
import Foundation
import SocketIO
import RxSwift
class SocketIOManager:NSObject{
    static let shared = SocketIOManager()
    override init() {
        super.init()
        socket = self.manager.socket(forNamespace: "/")
    }
    var manager = SocketManager(socketURL: URL(string: "http://172.30.1.6:3000")!)
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
    func disConnectToName(name:String){
        socket.emit("exitUser",name)
    }
    func sendMessage(msg:Message){
        socket.emit("chatMessage",msg.sender,msg.content,msg.receiver)
    }
    func getMessage() -> Observable<Message>{
        let subject = PublishSubject<Message>()
        socket.on("newChatMessage"){data,_ in
            var messageData = Message(sender: data[0] as! String, content: data[1] as! String, receiver: data[3] as! String)
            subject.onNext(messageData)
        }
        return subject
    }
}
