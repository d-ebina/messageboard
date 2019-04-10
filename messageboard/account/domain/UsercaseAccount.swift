//
//  AccountService.swift
//  message-board
//
//  Created by SUGAR-PC02 on 2019/04/09.
//  Copyright © 2019 SUGAR-PC02. All rights reserved.
//
import Hydra

protocol UsercaseAccount:class {
    /// アカウント情報を登録
    func resistAccount(accountName: String, password: String) -> Promise<AccountEntity>
    ///アカウント一覧を取得する
    var accountList: [AccountEntity]{get}
    /// アカウントをログイン状態にする
    func authorize(accountId: String) -> Promise<Swift.Void>
}




class UsercaseAccountImpl: UsercaseAccount {
    
    /// repositoryAccount
    private var repositoryAccount: RepositoryAccount!
    
    init() {
        repositoryAccount = container.resolve(RepositoryAccount.self)
    }
    
    func resistAccount(accountName: String, password: String) -> Promise<AccountEntity> {
        let newEntity = AccountEntity()
        newEntity.accountName = accountName
        newEntity.password = password
        return repositoryAccount.store(account: newEntity)
    }
    func authorize(accountId: String) -> Promise<Swift.Void> {
        return self.repositoryAccount.authorize(accountId: accountId)
    }
    
    var accountList: [AccountEntity] {
        return repositoryAccount.accounts
    }
}
