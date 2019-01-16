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
    var game: String = ""
    
    
    @IBOutlet weak var matchGameOutlet: UIButton!
    @IBOutlet weak var startButtonOutlet: UIButton!
    @IBOutlet weak var gameImage: UIImageView!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var memorizeGameOutlet: UIButton!
    
    @IBAction func startMatchGameButton(_ sender: UIButton) {
        memorizeGameOutlet.alpha = 0.3
        sender.alpha = 1
        gameImage.image = UIImage(named: "match")
        game = "Match"
        startButtonOutlet.alpha = 1
        startButtonOutlet.isUserInteractionEnabled = true
    }
    
    @IBAction func startGameButton(_ sender: UIButton) {
        if game == "Match" {
            showMatchGame()
        } else {
            showMemorizeGame()
        }
    }
    
    @IBAction func startMemorizeSoundsGameButton(_ sender: UIButton) {
        matchGameOutlet.alpha = 0.3
        sender.alpha = 1
        gameImage.image = UIImage(named: "memorize")
        game = "Memorize"
        startButtonOutlet.alpha = 1
        startButtonOutlet.isUserInteractionEnabled = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameImage.layer.borderWidth = 2
        matchGameOutlet.alpha = 0.3
        memorizeGameOutlet.alpha = 0.3
        startButtonOutlet.alpha = 0.3
        startButtonOutlet.isUserInteractionEnabled = false
        
        playerNameLabel.text = "\(playerName), choose your Game!"
    }
    
    func showMatchGame() {
        let matchGame = Storyboard.MatchGame.rawValue
        
        if let matchGameVC = UIStoryboard(name: matchGame, bundle: nil).instantiateViewController(withIdentifier: matchGame) as? MatchGameViewController {
            matchGameVC.playersName = playerName
            navigationController?.pushViewController(matchGameVC, animated: true)
            
        }
    }
    func showMemorizeGame() {
        let memorizeGame = Storyboard.MemorizeGame.rawValue
        
        if let memorizeSoundVC = UIStoryboard(name: memorizeGame, bundle: nil).instantiateViewController(withIdentifier: memorizeGame) as? MemorizeSoundsViewController {
            navigationController?.pushViewController(memorizeSoundVC, animated: true)
            
        }
    }
}
