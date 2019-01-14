//
//  GamePickerViewController.swift
//  Match-Match_Game_MemoryWarmUp
//
//  Created by Rustam Shorov on 13.01.2019.
//  Copyright © 2019 Rustam Shorov. All rights reserved.
//

import UIKit

class GamePickerViewController: UIViewController {
    
    var playerName: String = ""
    
    @IBOutlet weak var playerNameLabel: UILabel!
    
    @IBAction func startMatchGameButton(_ sender: UIButton) {
        
        if let matchGameVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MatchGameVC") as? MatchGameViewController {
            
            matchGameVC.playersName = playerName
            navigationController?.pushViewController(matchGameVC, animated: true)
            
        }
    }
    
    @IBAction func startMemorizeSoundsGameButton(_ sender: UIButton) {
        
        if let memorizeSoundVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MemorizeSoundVC") as? MemorizeSoundsViewController {
            navigationController?.pushViewController(memorizeSoundVC, animated: true)
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerNameLabel.text = "\(playerName), choose your Game!"
    }
    
//    func showTheGameWithIdentifier(_ identifier: String, controller: UIViewController) {
//
//        if let game = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier) as? controller {
//            navigationController?.pushViewController(game, animated: true)
//
//        }
//    }
    
}
