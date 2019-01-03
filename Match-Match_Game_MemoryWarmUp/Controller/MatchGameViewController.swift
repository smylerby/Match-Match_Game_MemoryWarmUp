//
//  ViewController.swift
//  Match-Match_Game_MemoryWarmUp
//
//  Created by Rustam Shorov on 02.01.2019.
//  Copyright © 2019 Rustam Shorov. All rights reserved.
//

import UIKit

class MatchGameViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var bottomLogView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var triesLabel: UILabel!


    var timer = TimerManager()
    
    var tryCounter = 0
    var cardArray = [Card]()
    let cardManager = CardDataManager()
    
    var firstFlippedCardIndex: IndexPath?
    var matchedPairsCounter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        cardArray = cardManager.getCard()
    }
    override func viewDidAppear(_ animated: Bool) {
        //Звук перемешивания карт при появлении экрана с картами приложения
        SoundManager.playSound(.shuffle)
        self.title = "Match-Match Game!"
        //Запуск таймера
        timer.startTimer(label: timeLabel)
        
    }
    
    func checkForMatches(_ secondFlippedCardIndex: IndexPath) {
        //Функция, запрещающая нажимать все карты подряд, после открытия второй карты вызывается метод isUserInteractionEnable для CollectionView
        disableTapping()
        
        //Вызов ячеек для сравнения
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell
        let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex) as? CardCollectionViewCell
        
        let cardOne = cardArray[firstFlippedCardIndex!.row]
        let cardTwo = cardArray[secondFlippedCardIndex.row]
        
        //При одинаковом названии изображения ячеек:
        if cardOne.imageName == cardTwo.imageName {
            
            cardTwo.isMatched = true
            cardOne.isMatched = true
            
            matchedPairsCounter += 2
            
            //Завершение игры
            if matchedPairsCounter == cardArray.count {
                timer.stopTimer()
                showAlert()
            }
            //Удаление совпавших карт с поля
            cardOneCell?.removeMathedCard()
            cardTwoCell?.removeMathedCard()
            
            SoundManager.playSound(.match)
            
        } else {
            
            //Обратный переворот карты при отсутсвии совпадения
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            
            cardOneCell?.flipBackCard()
            cardTwoCell?.flipBackCard()
            
            //Звук несовпадения
            SoundManager.playSound(.nomatch)
        }
        //
        if cardOneCell == nil {
            collectionView.reloadItems(at: [firstFlippedCardIndex!])
        }
        firstFlippedCardIndex = nil
        
        addTry()
    }
    
    //Алерт об успешном  окончании игры
    func showAlert() {
        
        let title = "Congratilations!"
        let message = "You've won!"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertActionRetry = UIAlertAction(title: "Retry", style: .default) { (_) in
            print("rematch!")
            self.rematch()
        }
        let alertActionShowResults = UIAlertAction(title: "Show results", style: .default) { _ in
            print("Just a second")
        }
        alert.addAction(alertActionRetry)
        alert.addAction(alertActionShowResults)
        present(alert, animated: true, completion: nil)
    }
    // Функция, предотвращающая нажатие всех карт подряд, максимум 2.
    func disableTapping() {
        collectionView.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.7) {
            self.collectionView.isUserInteractionEnabled = true
        }
    }
    func addTry() {
        tryCounter += 1
        triesLabel.text = String(tryCounter)
    }
    //Конец ViewController
    func rematch() {
        cardArray.removeAll()
        cardArray = cardManager.getCard()
//        self.view.setNeedsLayout()
        tryCounter = 0
        matchedPairsCounter = 0
    }

}

extension MatchGameViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //    Работа с коллекншВью
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemsPerRow: CGFloat = 4
        let amountOfRows: CGFloat = 5
        let sectionInsert = UIEdgeInsets(top: 11, left: 10, bottom: 10, right: 10)
        let bottomLogHeight = bottomLogView.frame.height
        
        let paddingSpaceLeft = sectionInsert.left * (itemsPerRow + 1)
        let paddingSpaceTop = sectionInsert.top * (amountOfRows + 1) + (self.navigationController?.navigationBar.frame.height)! + bottomLogHeight
        
        let availableWidth = view.frame.width - paddingSpaceLeft
        let availableHeight = view.frame.height - paddingSpaceTop
        
        let heightRow = availableHeight / amountOfRows
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: heightRow)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as! CardCollectionViewCell
        let card = cardArray[indexPath.row]
        cell.setCard(card)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        let card = cardArray[indexPath.row]
        
        if !(card.isFlipped && card.isMatched){
            
            cell.flipCard()
            card.isFlipped = true
            
            // Звук переворота карты
            SoundManager.playSound(.flip)
            
            if firstFlippedCardIndex == nil {
                
                firstFlippedCardIndex = indexPath
                
            } else {
                checkForMatches(indexPath)
            }
        }
    }
}


