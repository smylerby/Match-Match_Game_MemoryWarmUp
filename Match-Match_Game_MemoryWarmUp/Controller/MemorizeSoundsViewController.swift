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
    
    
    var sound1Player:AVAudioPlayer!
    var sound2Player:AVAudioPlayer!
    var sound3Player:AVAudioPlayer!
    var sound4Player:AVAudioPlayer!
    
    var playlist = [Int]()
    var currentItem = 0
    var numberOfTaps = 0
    var readyForUser = false
    
    var level = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudioFiles()
    }
    
    func setupAudioFiles (){
        
        let soundFilePath = Bundle.main.path(forResource: "1", ofType: "wav")
        
        let soundFileURL = NSURL(fileURLWithPath: soundFilePath!)
        
        let soundFilePath2 = Bundle.main.path(forResource: "2", ofType: "wav")
        let soundFileURL2 = NSURL(fileURLWithPath: soundFilePath2!)
        
        let soundFilePath3 = Bundle.main.path(forResource: "3", ofType: "wav")
        let soundFileURL3 = NSURL(fileURLWithPath: soundFilePath3!)
        
        let soundFilePath4 = Bundle.main.path(forResource: "4", ofType: "wav")
        let soundFileURL4 = NSURL(fileURLWithPath: soundFilePath4!)
        
        do {
            try sound1Player = AVAudioPlayer(contentsOf: soundFileURL as URL)
            try sound2Player = AVAudioPlayer(contentsOf: soundFileURL2 as URL)
            try sound3Player = AVAudioPlayer(contentsOf: soundFileURL3 as URL)
            try sound4Player = AVAudioPlayer(contentsOf: soundFileURL4 as URL)
            
        }catch {
            print(error)
        }
        
        sound1Player.delegate = self
        sound2Player.delegate = self
        sound3Player.delegate = self
        sound4Player.delegate = self
        
        sound1Player.numberOfLoops = 0
        sound2Player.numberOfLoops = 0
        sound3Player.numberOfLoops = 0
        sound4Player.numberOfLoops = 0
        
    }
    
    
    @IBAction func soundButton(_ sender: UIButton) {
        
        if readyForUser {
            let button = sender
            
            switch button.tag {
            case 1:
                sound1Player.play()
                checkIfCorrect(buttonPressed: 1)
                break
            case 2:
                sound2Player.play()
                checkIfCorrect(buttonPressed: 2)
                break
            case 3:
                sound3Player.play()
                checkIfCorrect(buttonPressed: 3)
                break
            case 4:
                sound4Player.play()
                checkIfCorrect(buttonPressed: 4)
                break
            default:
                break
            }
        }
    }

    
    func checkIfCorrect (buttonPressed:Int) {
        if buttonPressed == playlist[numberOfTaps] {
            if numberOfTaps == playlist.count - 1 { // we have arrived at the last item of the playlist
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    self.nextRound()
                }
//                let time = dispatch_time(dispatch_time_t(DispatchTime.now()), Int64(NSEC_PER_SEC))
//
//                dispatch_after(time, dispatch_get_main_queue(), {
//                    self.nextRound()
//                })
            
                return
            }
            
            numberOfTaps += 1
        }else{ // GAME OVER
            resetGame()
        }
    }
    
    
    func resetGame() {
        level = 1
        readyForUser = false
        numberOfTaps = 0
        currentItem = 0
        playlist = []
        levelLabel.text = "GAME OVER"
        startGameButton.isHidden = false
        disableButtons()
    }
    
    func nextRound() {
        
        level += 1
        levelLabel.text = "Level \(level)"
        readyForUser = false
        numberOfTaps = 0
        currentItem = 0
        disableButtons()
        
        
        let randomNumber = Int(arc4random_uniform(4) + 1)
        playlist.append(randomNumber)
        
        playNextItem()
        
        
        
    }
    
    @IBAction func startGame(sender: AnyObject) {
        levelLabel.text = "Level 1"
        disableButtons()
        let randomNumber = Int(arc4random_uniform(4) + 1)
        playlist.append(randomNumber)
        startGameButton.isHidden = true
        playNextItem()
        
        
    }
    
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if currentItem <= playlist.count - 1 {
            playNextItem()
        }else{
            readyForUser = true
            resetButtonHighlights()
            enableButtons()
        }
    }
    
    
    func playNextItem () {
        let selectedItem = playlist[currentItem]
        
        switch selectedItem {
        case 1:
            highlightButtonWithTag(tag: 1)
            sound1Player.play()
            break
        case 2:
            highlightButtonWithTag(tag: 2)
            sound2Player.play()
            break
        case 3:
            highlightButtonWithTag(tag: 3)
            sound3Player.play()
            break
        case 4:
            highlightButtonWithTag(tag: 4)
            sound4Player.play()
            break
        default:
            break;
        }
        
        currentItem += 1
        
    }
    
    func highlightButtonWithTag (tag:Int) {
        switch tag {
        case 1:
            resetButtonHighlights()
            soundButton[tag - 1].setImage(UIImage(named:"redPressed"), for: .normal)
        case 2:
            resetButtonHighlights()
            soundButton[tag - 1].setImage(UIImage(named:"yellowPressed"), for: .normal)
        case 3:
            resetButtonHighlights()
            soundButton[tag - 1].setImage(UIImage(named:"bluePressed"), for: .normal)
        case 4:
            resetButtonHighlights()
            soundButton[tag - 1].setImage(UIImage(named:"greenPressed"), for: .normal)
        default:
            break
        }
    }
    
    func resetButtonHighlights () {
        soundButton[0].setImage(UIImage(named: "red"), for: .normal)
        soundButton[1].setImage(UIImage(named: "yellow"), for: .normal)
        soundButton[2].setImage(UIImage(named: "blue"), for: .normal)
        soundButton[3].setImage(UIImage(named: "green"), for: .normal)
    }
    
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

