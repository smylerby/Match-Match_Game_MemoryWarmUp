//
//  RealmService.swift
//  Match-Match_Game_MemoryWarmUp
//
//  Created by Rustam Shorov on 03.01.2019.
//  Copyright © 2019 Rustam Shorov. All rights reserved.
//


// Соббственная (отчасти) реализация работы с Реалмом.
//Из этого используется только сохранение и чтение данных
//Но также можно работать с перезаписью и удалением


import Foundation
import RealmSwift

class RealmService {
    
    private init() {}
    static let shared = RealmService()
    
    var realm = try! Realm()
    //Сохранение
    func create<T: Object>(_ object: T) {
        do {
            
            try realm.write {
                realm.add(object)
            }
            
        } catch {
            post(error)
        }
    }
    //Обновление
    func update<T: Object>(_ object: T, with dictionary: [String: Any?]) {
        do {
            try realm.write {
                for (key, value) in dictionary {
                    object.setValue(value, forKey: key)
                }
            }
        } catch {
            post(error)
        }
    }
    //Удаление
    func delete<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            post(error)
        }
    }
    //MARK: Обработчик ошибок
    func  post(_ error: Error) {
        NotificationCenter.default.post(name: NSNotification.Name("RealmError"), object: error)
    }
    
    func observeRealmErrors(in vc: UIViewController, completion: @escaping(Error?) -> Void) {
        NotificationCenter.default.addObserver(forName: NSNotification.Name("RealmError"), object: nil, queue: nil) { (notification) in
            completion(notification.object as? Error)
        }
    }
    
    func stopObservingErrors(in vc: UIViewController) {
        NotificationCenter.default.removeObserver(vc, name: NSNotification.Name("RealmError"), object: nil)
    }
    
}

