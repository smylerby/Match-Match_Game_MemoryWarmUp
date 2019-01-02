//
//  TimerManager.swift
//  Match-Match_Game_MemoryWarmUp
//
//  Created by Rustam Shorov on 02.01.2019.
//  Copyright © 2019 Rustam Shorov. All rights reserved.
//

import UIKit

class TimerManager: timeCountable {
    
    private var timer = Timer()
    private var counter: Int = 0
    
    func startTimer(label: UILabel) {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block:  {_ in
            self.counter += 1
            label.text = String(self.counter)
        }   )
    }
    
    func stopTimer() {
        timer.invalidate()
    }
    
    
}
