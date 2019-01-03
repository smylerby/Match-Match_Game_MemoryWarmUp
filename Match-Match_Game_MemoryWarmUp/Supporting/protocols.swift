//
//  protocols.swift
//  Match-Match_Game_MemoryWarmUp
//
//  Created by Rustam Shorov on 02.01.2019.
//  Copyright © 2019 Rustam Shorov. All rights reserved.
//

import UIKit

protocol timeCountable {
    
    var timer: Timer {get}
    var counter: Int {get set}
    func startTimer(label: UILabel)
    func stopTimer()
}
