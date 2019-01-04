//
//  SoundManager.swift
//  Match-Match_Game_MemoryWarmUp
//
//  Created by Rustam Shorov on 02.01.2019.
//  Copyright © 2019 Rustam Shorov. All rights reserved.
//

import Foundation
import AVFoundation

class SoundManager {
    
    static var player: AVAudioPlayer?
    
    //Энамчик для 4х вариантов проигрывания звука
    enum SoundEffect {
        case flip, shuffle, match, nomatch
    }
    
    //Функция типа. Наш проигрыватель
    static func playSound(_ effect: SoundEffect) {
        
        var soundFilename = ""
        
        switch effect {
        case .flip:
            soundFilename = "cardflip"
        case .shuffle:
            soundFilename = "shuffle"
        case .match:
            soundFilename = "dingcorrect"
        case .nomatch:
            soundFilename = "dingwrong"
        }
        
        let bundlePath = Bundle.main.path(forResource: soundFilename, ofType: "wav")
        
        guard bundlePath != nil else {
            print("Error: Sound file doesn't exist!")
            return }
        
        //  Create an URL object fro this string path
        
        let soundURL = URL(fileURLWithPath: bundlePath!)
        
        //  Create APlayer
        do {
            player = try AVAudioPlayer(contentsOf: soundURL)
            player?.play()
            
        } catch {
            print("Couldn't create the player for this file: \(soundFilename)")
        }
    }
}
