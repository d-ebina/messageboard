//
//  RepositoryMessage.swift
//  message-board
//
//  Created by SUGAR-PC02 on 2019/04/09.
//  Copyright © 2019 SUGAR-PC02. All rights reserved.
//

import UIKit
import Hydra


protocol RepositoryMessage  {
    func store(message: MessageEntity) -> Promise<MessageEntity>
    func store(targetMessage: MessageEntity, replyMessage: MessageEntity) -> Promise<Void>
    func message(messageId: String) -> MessageEntity?
    var messages: [MessageEntity] {get}
}

class RepositoryMessageImpl: BaseRepository, RepositoryMessage, RepositoryPresentable {
    typealias T = MessageEntity
    func store(message: MessageEntity) -> Promise<MessageEntity> {
        return self.store(message)
    }
    func store(targetMessage: MessageEntity, replyMessage: MessageEntity) -> Promise<Void> {
        return self.transaction{
            targetMessage.messageReplyList.append(replyMessage)
        }
    }
    
    func message(messageId: String) -> MessageEntity? {
        return self.find(by: messageId)
    }
    
    var messages: [MessageEntity] {
        return self.findAll()
    }
    
    
    
}
