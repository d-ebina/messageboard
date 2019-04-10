//
//  MessageEntity.swift
//  message-board
//
//  Created by SUGAR-PC02 on 2019/04/09.
//  Copyright © 2019 SUGAR-PC02. All rights reserved.
//

import UIKit
import RealmSwift
/// MessageEntity
class MessageEntity: Object {
    @objc dynamic var id: String = NSUUID().uuidString
    @objc dynamic var messageContent
        = ""
    @objc dynamic var registDate = Date()
    @objc dynamic var messageTitle
        = ""
    @objc dynamic var registAccount: AccountEntity?
    var messageReplyList = List<MessageEntity>()
}
