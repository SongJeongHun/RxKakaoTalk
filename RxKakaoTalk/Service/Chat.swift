////
////  Chat.swift
////  RxKakaoTalk
////
////  Created by 송정훈 on 2021/01/06.
////
//
//import Foundation
//import RxSwift
//import RxCocoa
//class chat:ChatType{
//    lazy var list = chatList()
////    var storage = BehaviorSubject<[Message]>(value: )
//    @discardableResult
//    func sendMessage(msg: Message) -> Observable<Message> {
//    }
//    @discardableResult
//    func chatList() -> Observable<[Message]> {
//    }
//}
//
//
struct Message{
    var sender:String
    var content:String
    var receiver:String
    var timeStamp:String
    init(sender:String,content:String,receiver:String,timeStamp:String){
        self.sender = sender
        self.content = content
        self.receiver = receiver
        self.timeStamp = timeStamp
    }
}
