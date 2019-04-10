//
//  BaseRepository.swift
//  message-board
//
//  Created by SUGAR-PC02 on 2019/04/09.
//  Copyright © 2019 SUGAR-PC02. All rights reserved.
//

import UIKit
import Hydra
import RealmSwift
class BaseRepository{
    var realmObject: Realm = try! Realm()
}
// 基本的crud
protocol RepositoryPresentable {
    associatedtype T: Object
    var realmObject: Realm {get set}
    func find(by primary: String) -> T?
    func findAll() -> [T]
    func find(by predicateFormat: String, _ args: Any...) -> T?
    func store(_ entity: T) -> Promise<T>
    func remove(_ entity: T) -> Promise<Swift.Void>
    func transaction(_ proc: @escaping () -> Void) -> Promise<Swift.Void>
    
}
extension RepositoryPresentable where Self: BaseRepository {
    func find(by primary: String) -> T? {
        return find(by: "id == %@", primary)
    }
    func findAll() -> [T] {
        return realmObject.objects(T.self).map({$0})
    }
    func find(by predicateFormat: String, _ args: Any...) -> T? {
        return realmObject.objects(T.self).filter(predicateFormat, args).first
    }
    
    func store(_ entity: T) -> Promise<T> {
        return Promise<T> { (resolve, reject, _) in
            do{
                try self.realmObject.write {
                    self.realmObject.add(entity, update: true)
                    resolve(entity)
                }
            } catch let error {
                reject(error)
            }
        }
    }
    
    func remove(_ entity: T) -> Promise<Swift.Void> {
        return Promise<Swift.Void> { (resolve, reject, _) in
            do{
                try self.realmObject.write {
                    self.realmObject.delete(entity)
                    resolve(())
                }
            } catch let error {
                reject(error)
            }
        }
    }
    
    // トランザクション
    func transaction(_ proc: @escaping () -> Void) -> Promise<Swift.Void> {
        return Promise<Swift.Void> { (resolve, reject, _) in
            do{
                try self.realmObject.write {
                    proc()
                    resolve(())
                }
            } catch let error {
                reject(error)
            }
        }
    }
}
