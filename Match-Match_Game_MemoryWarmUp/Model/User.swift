//
//  User.swift
//  Match-Match_Game_MemoryWarmUp
//
//  Created by Rustam Shorov on 03.01.2019.
//  Copyright © 2019 Rustam Shorov. All rights reserved.
//

import Foundation
import RealmSwift


//Модель ячейки игрока

@objcMembers class User: Object {
    
    dynamic var name: String = ""
    dynamic var time: Int = 0
    let tries = RealmOptional<Int>()
    
    convenience init(name: String, time: Int, tries: Int) {
        self.init()
        self.name = name
        self.time = time
        self.tries.value = tries
    }
    
    func triesInt() -> Int? {
        guard let tries = tries.value else {
            return nil
        }
        return Int(tries)
    }
    
}

