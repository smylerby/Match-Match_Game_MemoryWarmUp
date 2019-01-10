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

    @IBOutlet weak var playButtonPressed: UIButton!
    @IBOutlet var soundButton: [UIButton]!
    @IBOutlet weak var levelLabel: UILabel!
//    
//    var sound1Player: AVAudioPlayer!
//    var sound2Player: AVAudioPlayer!
//    var sound3Player: AVAudioPlayer!
//    var sound4Player: AVAudioPlayer!
    
    var playlist = [Int]()
    var currentItem = 0
    var numbersOfTaps = 0
    var readyForUser = false
    
    var level = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        setUpAudioFiles()
//
        
    }
    
//    func setUpAudioFiles() {
//
//        let soundFilePath = Bundle.main.path(forResource: "1", ofType: "wav")
//        let soundFileUrl = URL(fileURLWithPath: soundFilePath!)
//
//        let soundFilePath2 = Bundle.main.path(forResource: "2", ofType: "wav")
//        let soundFileUrl2 = URL(fileURLWithPath: soundFilePath2!)
//
//        let soundFilePath3 = Bundle.main.path(forResource: "3", ofType: "wav")
//        let soundFileUrl3 = URL(fileURLWithPath: soundFilePath3!)
//
//        let soundFilePath4 = Bundle.main.path(forResource: "4", ofType: "wav")
//        let soundFileUrl4 = URL(fileURLWithPath: soundFilePath4!)
//
//        do {
//            try sound1Player = AVAudioPlayer(contentsOf: soundFileUrl)
//            try sound2Player = AVAudioPlayer(contentsOf: soundFileUrl2)
//            try sound3Player = AVAudioPlayer(contentsOf: soundFileUrl3)
//            try sound4Player = AVAudioPlayer(contentsOf: soundFileUrl4)
//        } catch {
//            print(error)
//        }
//
//        sound1Player.delegate = self
//        sound2Player.delegate = self
//        sound3Player.delegate = self
//        sound4Player.delegate = self
//
//        sound1Player.numberOfLoops = 0
//        sound2Player.numberOfLoops = 0
//        sound3Player.numberOfLoops = 0
//        sound4Player.numberOfLoops = 0
//
//    }
    

    @IBAction func soundButtonPressed(_ sender: UIButton) {
        
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

extension MemorizeSoundsViewController: AVAudioPlayerDelegate {
    
    
    
}
