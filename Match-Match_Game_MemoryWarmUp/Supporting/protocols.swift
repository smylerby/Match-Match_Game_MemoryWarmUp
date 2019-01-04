//
//  protocols.swift
//  Match-Match_Game_MemoryWarmUp
//
//  Created by Rustam Shorov on 02.01.2019.
//  Copyright © 2019 Rustam Shorov. All rights reserved.
//


//Не самый нужный протокол, но это для того, чтобы показать, что я умею их создавать :)

import UIKit

protocol timeCountable {
    
    var timer: Timer {get}
    var counter: Int {get set}
    func startTimer(label: UILabel)
    func stopTimer()
}
