//
//  MemorizeSoundsViewController.swift
//  Match-Match_Game_MemoryWarmUp
//
//  Created by Rustam Shorov on 10.01.2019.
//  Copyright © 2019 Rustam Shorov. All rights reserved.
//

import UIKit
import AVFoundation


class MemorizeSoundsViewController: UIViewController {

    @IBOutlet var soundButtonArray: [UIButton]!
    
    @IBOutlet weak var playButtonPressed: UIButton!
    
    @IBOutlet weak var levelLabel: UILabel!

    var playlist = [Int]()
    var currentItem = 0
    var numbersOfTaps = 0
    var readyForUser = false
    
    var level = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func soundButtonPressed(_ sender: UIButton) {
        
        if readyForUser {
            switch sender.tag {
            case 1:
                SoundManager.playSound(.red)
            case 2:
                SoundManager.playSound(.yellow)
            case 3:
                SoundManager.playSound(.blue)
            case 4:
                SoundManager.playSound(.green)
            default:
                break
            }
        }
    }
    
    func checkIfCorrect (buttonPressed: Int) {
        if buttonPressed == playlist[numbersOfTaps] {
            if numbersOfTaps == playlist.count - 1 {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.7) {
                    self.nextRound()
                }
                return
            }
            numbersOfTaps += 1
        } else {
            resetGame()
            //GameOver
        }
    }
    
    func resetGame() {
        level = 1
        readyForUser = false
        numbersOfTaps = 0
        playlist = []
        levelLabel.text = "Game Over"
        playButtonPressed.isHidden = false
    }
    
    func nextRound() {
        level += 1
        levelLabel.text = "Level \(level)"
        readyForUser = false
        numbersOfTaps = 0
        currentItem = 0
        disableButtons()
        let randomNumber = Int(arc4random_uniform(4) + 1)
        playlist.append(randomNumber)
        playNextItem()
        //diable Button
    }
    
    @IBAction func playButtonPressedAction(_ sender: UIButton) {
        levelLabel.text = "Level 1"
        disableButtons()
        let randomNumber = Int(arc4random_uniform(4) + 1)
        playlist.append(randomNumber)
        playButtonPressed.isHidden = true
        playNextItem()
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if currentItem <= playlist.count - 1 {
            playNextItem()
        } else {
            readyForUser = true
            resetButtonHighLights()
            enableButtons()
        }
    }
    
    func playNextItem() {
        
        let selectedItem = playlist[currentItem]
        highlightButtonWith(tag: selectedItem)
        
        switch selectedItem {
        case 1:
            SoundManager.playSound(.red)
            break
        case 2:
            SoundManager.playSound(.yellow)
            break
        case 3:
            SoundManager.playSound(.blue)
            break
        case 4:
            SoundManager.playSound(.green)
            break
        default:
            break
        }
        currentItem += 1
    }
    
    func highlightButtonWith(tag: Int) {
        resetButtonHighLights()
        
        switch tag {
        case 1:
            soundButtonArray[tag - 1].setImage(UIImage(named: "redPressed"), for: .normal)
        case 2:
            soundButtonArray[tag - 1].setImage(UIImage(named: "yellowPressed"), for: .normal)
        case 3:
            soundButtonArray[tag - 1].setImage(UIImage(named: "bluePressed"), for: .normal)
        case 4:
            soundButtonArray[tag - 1].setImage(UIImage(named: "greenPressed"), for: .normal)
        default:
            break
        }
    }
    func resetButtonHighLights() {
        soundButtonArray[0].setImage(UIImage(named: "red"), for: .normal)
        soundButtonArray[1].setImage(UIImage(named: "yellow"), for: .normal)
        soundButtonArray[2].setImage(UIImage(named: "blue"), for: .normal)
        soundButtonArray[3].setImage(UIImage(named: "green"), for: .normal)
    }
    func disableButtons() {
        for button in soundButtonArray {
            button.isUserInteractionEnabled = false
        }
    }
    
    func enableButtons() {
        for button in soundButtonArray {
            button.isUserInteractionEnabled = true
        }
    }
}

extension MemorizeSoundsViewController: AVAudioPlayerDelegate {
    
    
    
}
