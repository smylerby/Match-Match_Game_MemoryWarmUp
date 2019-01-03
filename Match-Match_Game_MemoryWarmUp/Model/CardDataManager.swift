//
//  CardModel.swift
//  Match-Match_Game_MemoryWarmUp
//
//  Created by Rustam Shorov on 02.01.2019.
//  Copyright © 2019 Rustam Shorov. All rights reserved.
//

import UIKit

class CardDataManager {
    
    func getCard() -> [Card] {
        
        var generatedCardArray = [Card]()
        var genetatedRandomNumbersArray = [UInt32]()
        
        while genetatedRandomNumbersArray.count < 10 {
            
            let randomNumber = arc4random_uniform(11)
            
            if genetatedRandomNumbersArray.contains(randomNumber) == false {
                genetatedRandomNumbersArray.append(randomNumber)
                
                let cardOne = Card()
                cardOne.imageName = "card\(randomNumber)"
                generatedCardArray.append(cardOne)
                
                let cardTwo = Card()
                cardTwo.imageName = "card\(randomNumber)"
                generatedCardArray.append(cardTwo)
            }
        }
        
        generatedCardArray.shuffle()
        return generatedCardArray
    }
    
}
