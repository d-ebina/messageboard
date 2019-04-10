//
//  MessageService.swift
//  message-board
//
//  Created by SUGAR-PC02 on 2019/04/09.
//  Copyright © 2019 SUGAR-PC02. All rights reserved.
//

import UIKit
import Hydra

protocol UsecaseMessage:class {
    /// messageReply情報を登録
    func resistMessageReply(message: MessageEntity, messageTitle:String, messageContent: String) -> Promise<Void>
    /// message情報を登録
    func resistMessage(messageTitle: String, messageContent: String) -> Promise<MessageEntity>
    ///message一覧を取得する
    var messageList: [MessageEntity] {get}
}

class UsecaseMessageImpl: UsecaseMessage {
    private var repositoryMessage: RepositoryMessage!
    private var repositoryAccount: RepositoryAccount!
    
    init() {
        repositoryMessage = container.resolve(RepositoryMessage.self)
        repositoryAccount = container.resolve(RepositoryAccount.self)
    }
    
    func resistMessageReply(message: MessageEntity, messageTitle: String, messageContent: String) -> Promise<Void> {
        let newEntity = MessageEntity()
        newEntity.messageContent = messageContent
        newEntity.messageTitle = messageTitle
        newEntity.registAccount = repositoryAccount.currentAccount
        return repositoryMessage.store(targetMessage: message, replyMessage: newEntity)
    }
    
    func resistMessage(messageTitle:String, messageContent: String) -> Promise<MessageEntity> {
        let newEntity = MessageEntity()
        newEntity.messageContent = messageContent
        newEntity.messageTitle = messageTitle
        newEntity.registAccount = repositoryAccount.currentAccount
        return repositoryMessage.store(message: newEntity)
    }
    
    var messageList: [MessageEntity] {
        return self.repositoryMessage.messages
    }
}
