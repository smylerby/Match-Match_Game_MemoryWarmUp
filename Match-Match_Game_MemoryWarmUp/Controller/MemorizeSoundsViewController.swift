//
//  File.swift
//  Match-Match_Game_MemoryWarmUp
//
//  Created by Rustam Shorov on 10.01.2019.
//  Copyright © 2019 Rustam Shorov. All rights reserved.
//

import UIKit
import AVFoundation


class MemorizeSoundsViewController: UIViewController, AVAudioPlayerDelegate {
    
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet var soundButton: [UIButton]!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    
    var timer = Timer()
    var playlist = [Int]()
    var level = 1
    var isUsersTurn = false
    var numberOfTaps = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func startGame(sender: AnyObject) {
        
        disableButtons()
        playlist = randomizeSequence()
        startGameButton.isHidden = true
        playSequence()
        
    }
    
    @IBAction func soundButton(_ sender: UIButton) {
        tapButtonWithTag(sender.tag)
        checkIfCorrect(sender.tag)
    }
    
    func resetGame() {
        
        playlist.removeAll()
        level = 1
        levelLabel.text = "Level \(level)"
        numberOfTaps = 0
        isUsersTurn = false
        startGameButton.isHidden = false
        statusLabel.text = "Game Over =("
        disableButtons()
    }
    
    func randomizeSequence() -> [Int] {
        
        var randomizedArray = [Int]()
        for _ in 1...level {
            let num = Int(arc4random_uniform(4)) + 1
            randomizedArray.append(num)
        }
        return randomizedArray
    }
    
    func playSequence() {
        
        statusLabel.text = "Pay attention!"
        var index = 0
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (_) in
            
            self.highlightButtonWithTag(self.playlist[index])
            index += 1
            
            if index == self.playlist.count {
                self.timer.invalidate()
                index = 0
                
                self.isUsersTurn = true
                self.enableButtons()
            }
        })
    }
    
    func highlightButtonWithTag(_ tag: Int) {
        
        SoundManager.playSound(String(tag))
        soundButton[tag - 1].setImage(UIImage(named:String(tag)), for: .normal)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.25) {
            self.resetButtonWithTag(tag)
            
        }
    }
    
    func resetButtonWithTag(_ tag: Int) {
        soundButton[tag - 1].setImage(UIImage(named: "\(tag)normal"), for: .normal)
    }
    
    func checkIfCorrect(_ buttonPressed: Int) {
        
        if buttonPressed == playlist[numberOfTaps] {
            if numberOfTaps == playlist.count - 1 {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.7) {
                    self.nextRound()
                }
            }
            numberOfTaps += 1
        } else {
            resetGame()
        }
    }
    
    func nextRound() {
        level += 1
        levelLabel.text = "Level \(level)"
        isUsersTurn = false
        numberOfTaps = 0
        disableButtons()
        playlist.removeAll()
        playlist = randomizeSequence()
        playSequence()
    }
    
    func tapButtonWithTag(_ tag: Int) {
        highlightButtonWithTag(tag)
    }
    
    //
    func disableButtons () {
        for button in soundButton {
            button.isUserInteractionEnabled = false
        }
    }
    
    func enableButtons () {
        for button in soundButton {
            button.isUserInteractionEnabled = true
        }
    }
    
    
}
