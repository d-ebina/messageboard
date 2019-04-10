//
//  RepositoryAccount.swift
//  message-board
//
//  Created by SUGAR-PC02 on 2019/04/09.
//  Copyright © 2019 SUGAR-PC02. All rights reserved.
//

import UIKit
import Hydra

protocol RepositoryAccount {
    func store(account: AccountEntity) -> Promise<AccountEntity>
    func account(accountId: String) -> AccountEntity?
    var currentAccount: AccountEntity? {get}
    var accounts: [AccountEntity] {get}
    func authorize(accountId: String) -> Promise<Swift.Void>
}

class RepositoryAccountImpl: BaseRepository, RepositoryAccount, RepositoryPresentable {
    typealias T = AccountEntity
    func store(account: AccountEntity) -> Promise<AccountEntity> {
        return self.store(account)
    }
    
    func account(accountId: String) -> AccountEntity? {
        return self.find(by: accountId)
    }
    
    var accounts: [AccountEntity] {
        return self.findAll()
        
    }
    
    var currentAccount: AccountEntity? {
        return self.find(by: "isAuthorized == %@", true)
    }
    
    func authorize(accountId: String) -> Promise<Swift.Void>  {
        return self.transaction {
            for element in self.accounts {
                if element.id == accountId{
                    element.isAuthorized = true
                } else {
                    element.isAuthorized = false
                }
            }
        }
    }
}
