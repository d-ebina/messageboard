//
//  AccountEntity.swift
//  message-board
//
//  Created by SUGAR-PC02 on 2019/04/09.
//  Copyright © 2019 SUGAR-PC02. All rights reserved.
//

import UIKit
import RealmSwift

/// AccountEntity
class AccountEntity: Object {
    @objc dynamic var id: String = NSUUID().uuidString
    @objc dynamic var accountName
        = ""
    @objc dynamic var password
        = ""
    @objc dynamic var isAuthorized
        = false
}
