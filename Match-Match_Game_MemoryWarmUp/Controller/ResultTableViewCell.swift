//
//  ResultTableViewCell.swift
//  Match-Match_Game_MemoryWarmUp
//
//  Created by Rustam Shorov on 03.01.2019.
//  Copyright © 2019 Rustam Shorov. All rights reserved.
//

import UIKit

class ResultTableViewCell: UITableViewCell {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userTime: UILabel!
    @IBOutlet weak var userTries: UILabel!
    
    
    func configure(with user: User) {
        userName.text = user.name
        userTime.text = String(user.time)
        userTries.text = String(user.triesInt()!)
        
    }
}
