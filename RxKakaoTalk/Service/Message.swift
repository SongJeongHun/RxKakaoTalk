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
    
    init(sender:String,content:String,receiver:String){
        self.sender = sender
        self.content = content
        self.receiver = receiver
        
    }
}
