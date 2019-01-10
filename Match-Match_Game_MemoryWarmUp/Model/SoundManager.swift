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
        case red, blue, yellow, green
    }
    
    //Функция типа. Наш проигрыватель
    static func playSound(_ effect: SoundEffect) {
        
        var soundFilename = ""
        
        switch effect {
            //MatchMatchGame
        case .flip:
            soundFilename = "cardflip"
        case .shuffle:
            soundFilename = "shuffle"
        case .match:
            soundFilename = "dingcorrect"
        case .nomatch:
            soundFilename = "dingwrong"
            //MemorizeSounds
        case .red:
            soundFilename = "1"
        case .blue:
            soundFilename = "3"
        case .yellow:
            soundFilename = "2"
        case .green:
            soundFilename = "4"
        }
        //Ищем файлы звука в проекте с определенным расширением
        let bundlePath = Bundle.main.path(forResource: soundFilename, ofType: "wav")
        
        guard bundlePath != nil else {
            print("Error: Sound file doesn't exist!")
            return }
        
        // Создаем путь по такому-то адресу
        
        let soundURL = URL(fileURLWithPath: bundlePath!)
        
        //  Создаем проигрыватель
        do {
            player = try AVAudioPlayer(contentsOf: soundURL)
            player?.play()
            
        } catch {
            print("Couldn't create the player for this file: \(soundFilename)")
        }
    }
    
}
