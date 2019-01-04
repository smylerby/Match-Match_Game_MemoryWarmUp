//
//  CardCollectionViewCell.swift
//  Match-Match_Game_MemoryWarmUp
//
//  Created by Rustam Shorov on 02.01.2019.
//  Copyright © 2019 Rustam Shorov. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var frontImageView: UIImageView!
    @IBOutlet weak var backImageView: UIImageView!
    
    var card: Card?
    
    func setCard(_ card: Card) {
        self.card = card
        frontImageView.image = UIImage(named: card.imageName)
        
    }
    
    //MARK: Анимация
    // Переворот на фронталбную часть
    func flipCard() {
        self.isUserInteractionEnabled = false
        UIView.transition(from: backImageView, to: frontImageView, duration: 0.4, options: [.transitionFlipFromLeft,.showHideTransitionViews], completion: nil)
        
    }
    // Переворот обратно к задней части карты
    func flipBackCard() {
        self.isUserInteractionEnabled = true
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            UIView.transition(from: self.frontImageView, to: self.backImageView, duration: 0.4, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
        }
    }
    // Удаление карт
    func removeMathedCard() {
        //Делаем их полностью прозрачными
        backImageView.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0.6, options: .curveEaseOut, animations: {
            self.frontImageView.alpha = 0
        }, completion: nil)
    }
}
