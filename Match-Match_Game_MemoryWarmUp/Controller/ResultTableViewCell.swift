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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
