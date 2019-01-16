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
    
    
    var playlist = [Int]()
    var level = 1
    var isUsersTurn = false
    
    //    var soundPlayer: AVAudioPlayer!
    //    var currentItem = 0
    //    var numberOfTaps = 0
    //    var readyForUser = false
    //
    //
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func startGame(sender: AnyObject) {
        
        playlist = randomizeSequence()
        levelLabel.text = "Level 1"
        startGameButton.isHidden = true
        
        //            disableButtons()
        //            playNextItem()
        //
        
    }
    
    @IBAction func soundButton(_ sender: UIButton) {
        
        //        if readyForUser {
        SoundManager.playSound(String(sender.tag))
        
        //        }
    }
    
    func randomizeSequence() -> [Int] {
        var randomizedArray = [Int]()
        for _ in 1...level {
            let num = Int(arc4random_uniform(4)) + 1
            randomizedArray.append(num)
            print(randomizedArray)
        }
        return randomizedArray
    }
    
    func playSequence() {
        while playlist.count > 0 {
            
        }
    }
    func highlightButtonWithTag(_ tag: Int) {
        soundButton[tag - 1].setImage(UIImage(named:"redPressed"), for: .normal)
    }
    
    //    func checkIfCorrect (buttonPressed:Int) {
    //        if buttonPressed == playlist[numberOfTaps] {
    //            if numberOfTaps == playlist.count - 1 { // we have arrived at the last item of the playlist
    //
    //                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
    //                    self.nextRound()
    //                }
    //                return
    //            }
    //
    //            numberOfTaps += 1
    //        }else{ // GAME OVER
    //            resetGame()
    //        }
    //    }
    //
    //    func resetGame() {
    //        level = 1
    //        readyForUser = false
    //        numberOfTaps = 0
    //        currentItem = 0
    //        playlist = []
    //        levelLabel.text = "GAME OVER"
    //        startGameButton.isHidden = false
    //        disableButtons()
    //    }
    //
    //    func nextRound() {
    //
    //        level += 1
    //        levelLabel.text = "Level \(level)"
    //        readyForUser = false
    //        numberOfTaps = 0
    //        currentItem = 0
    //        disableButtons()
    //
    //
    //        let randomNumber = Int(arc4random_uniform(4) + 1)
    //        playlist.append(randomNumber)
    //        playNextItem()
    //
    //
    //    }
    //
    
    //
    //
    //    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
    //        if currentItem <= playlist.count - 1 {
    //            playNextItem()
    //        }else{
    //            readyForUser = true
    //            resetButtonHighlights()
    //            enableButtons()
    //        }
    //    }
    //
    //
    //    func playNextItem () {
    //        let selectedItem = playlist[currentItem]
    //
    //        switch selectedItem {
    //        case 1:
    //            highlightButtonWithTag(tag: 1)
    //            SoundManager.playSound("1")
    //            break
    //        case 2:
    //            highlightButtonWithTag(tag: 2)
    //            SoundManager.playSound("2")
    //            break
    //        case 3:
    //            highlightButtonWithTag(tag: 3)
    //            SoundManager.playSound("3")
    //            break
    //        case 4:
    //            highlightButtonWithTag(tag: 4)
    //            SoundManager.playSound("4")
    //            break
    //        default:
    //            break;
    //        }
    //
    //        currentItem += 1
    //
    //    }
    //
    //    func highlightButtonWithTag (tag:Int) {
    //        switch tag {
    //        case 1:
    //            resetButtonHighlights()
    //            soundButton[tag - 1].setImage(UIImage(named:"redPressed"), for: .normal)
    //        case 2:
    //            resetButtonHighlights()
    //            soundButton[tag - 1].setImage(UIImage(named:"yellowPressed"), for: .normal)
    //        case 3:
    //            resetButtonHighlights()
    //            soundButton[tag - 1].setImage(UIImage(named:"bluePressed"), for: .normal)
    //        case 4:
    //            resetButtonHighlights()
    //            soundButton[tag - 1].setImage(UIImage(named:"greenPressed"), for: .normal)
    //        default:
    //            break
    //        }
    //    }
    //
    //    func resetButtonHighlights () {
    //        soundButton[0].setImage(UIImage(named: "red"), for: .normal)
    //        soundButton[1].setImage(UIImage(named: "yellow"), for: .normal)
    //        soundButton[2].setImage(UIImage(named: "blue"), for: .normal)
    //        soundButton[3].setImage(UIImage(named: "green"), for: .normal)
    //    }
    //
    //    func disableButtons () {
    //        for button in soundButton {
    //            button.isUserInteractionEnabled = false
    //        }
    //    }
    //
    //    func enableButtons () {
    //        for button in soundButton {
    //            button.isUserInteractionEnabled = true
    //        }
    //    }
    //
    //}
    //
}
