//
//  CardModel.swift
//  Match-Match_Game_MemoryWarmUp
//
//  Created by Rustam Shorov on 02.01.2019.
//  Copyright © 2019 Rustam Shorov. All rights reserved.
//

import UIKit

class CardDataManager {

    
    //Функция генерации массива с картами
    
    
    func getCard() -> [Card] {
        
        var generatedCardArray = [Card]() //Массив наших карт
        var genetatedRandomNumbersArray = [UInt32]() //Массив для храниния номеров из метода "рандом"
        
        while genetatedRandomNumbersArray.count < 10 {
            //Генерируем число от 0 до 11
            let randomNumber = arc4random_uniform(11)
            
            //Если этого числа ЕЩЕ нет в массиве2 - пускаем дальше
            if genetatedRandomNumbersArray.contains(randomNumber) == false {
                // И закидываем сгенерированное число в массив2
                genetatedRandomNumbersArray.append(randomNumber)
                
                // Закидываем 2 одинковые карты в массив1
                let cardOne = Card()
                cardOne.imageName = "card\(randomNumber)"
                generatedCardArray.append(cardOne)
                
                let cardTwo = Card()
                cardTwo.imageName = "card\(randomNumber)"
                generatedCardArray.append(cardTwo)
            }
        }
        //Перемешивание массива
        generatedCardArray.shuffle()
        return generatedCardArray
    }
    
}
