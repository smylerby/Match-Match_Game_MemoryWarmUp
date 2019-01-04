//
//  ViewController.swift
//  Match-Match_Game_MemoryWarmUp
//
//  Created by Rustam Shorov on 02.01.2019.
//  Copyright © 2019 Rustam Shorov. All rights reserved.
//

import UIKit
import RealmSwift

class MatchGameViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var bottomLogView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var triesLabel: UILabel!
    
    var playersName: String = ""
    //Переменные для нижней панели(таймер и счетчик переворотов)
    var timer = TimerManager()
    var tryCounter = 0
    //счетчик количества совпадений
    var matchedPairsCounter = 0
    //Массивы перемешанных карт
    var cardArray = [Card]()
    let cardManager = CardDataManager()
    
    var firstFlippedCardIndex: IndexPath?
//
//    let imageView: UIImageView = {
//        let image = UIImageView()
//        image.image = UIImage(named: "background_1")
//        image.contentMode = .scaleAspectFill
//        return image
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.backgroundView = UIImageView(image: UIImage(named: "background_1"), highlightedImage: nil)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //запись в массив перемешанных карт
        cardArray = cardManager.getCard()
        
        //Звук перемешивания карт
        SoundManager.playSound(.shuffle)
        //
        self.title = "\(playersName)'s game!"
        //Запуск таймера
        timer.startTimer(label: timeLabel)
        
    }
    // MARK: - Главная функция сравнения карт
    func checkForMatches(_ secondFlippedCardIndex: IndexPath) {
        
        //Вызов ячеек для сравнения
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell
        let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex) as? CardCollectionViewCell
        
        
        let cardOne = cardArray[firstFlippedCardIndex!.row]
        let cardTwo = cardArray[secondFlippedCardIndex.row]
        
        //При одинаковом названии изображения ячеек:
        if cardOne.imageName == cardTwo.imageName {
            
            cardTwo.isMatched = true
            cardOne.isMatched = true
            //Так как удаляются сразу 2 карты, поэтому +=2
            matchedPairsCounter += 2
            //Завершение игры (Счетчик совпадений равен количеству элементов массива)
            if matchedPairsCounter == cardArray.count {
                timer.stopTimer()
                showAlert()
            }
            //Удаление совпавших карт с поля
            cardOneCell?.removeMathedCard()
            cardTwoCell?.removeMathedCard()
            //Звук совпавшей пары
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
        
        //функция подсчитывает попытки найти совпадения
        addTry()
        
        //Функция, запрещающая нажимать все карты подряд, после открытия второй карты вызывается метод isUserInteractionEnable для CollectionView
        disableTapping()
    }
    
    //Алерт об успешном  окончании игры
    func showAlert() {
        
        let title = "You've won!"
        let message = "The result is: \(timer.counter) sec., \(tryCounter) attempts!"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
    //Доп. попытка без записи результата
        let alertActionRetry = UIAlertAction(title: "Retry", style: .default) { _ in
            self.reloadView()
        }
    // Запись результата и презентация таблицы результатов
        let alertActionShowResults = UIAlertAction(title: "Save result", style: .default) { _ in
            self.savePlayersData()
            let resultsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "resultsVC") as! ResultsViewController
            self.present(resultsVC, animated: true, completion: nil)
        }
    //Добавление  кнопок в Алерт
        alert.addAction(alertActionRetry)
        alert.addAction(alertActionShowResults)
    //Показать Алерт
        present(alert, animated: true, completion: nil)
    }
    // Функция, предотвращающая нажатие всех карт подряд, максимум 2.
    func disableTapping() {
        collectionView.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.7) {
            self.collectionView.isUserInteractionEnabled = true
        }
    }
    //    Счетчик количества переворотов пары карт
    func addTry() {
        tryCounter += 1
        triesLabel.text = String(tryCounter)
    }
    
    //    Перезапуск игры
    func reloadView() {
        timer.reset()
        tryCounter = 0
        matchedPairsCounter = 0
        let parent = view.superview
        view.removeFromSuperview()
        view = nil
        parent?.addSubview(view)
    }
    //Конец ViewController
}


extension MatchGameViewController: UICollectionViewDelegateFlowLayout {
    //    Работа с коллекншВью
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //Определяем количество строк и столбцов
        let itemsPerRow: CGFloat = 4
        let amountOfRows: CGFloat = 5
       
        //определяем расстояние между картами
        let sectionInsert = UIEdgeInsets(top: 11, left: 10, bottom: 10, right: 10)
        let bottomLogHeight = bottomLogView.frame.height
        
        //определяем размеры экрана, которое будем делить на количество строк и столбцов
        //так как на экране есть НавигейшнБар, поля с таймером и отступы от карт, то отнимаем эти размеры от размера экрана
        let paddingSpaceLeft = sectionInsert.left * (itemsPerRow + 1)
        let paddingSpaceTop = sectionInsert.top * (amountOfRows + 1) + (self.navigationController?.navigationBar.frame.height)! + bottomLogHeight
        
        let availableWidth = view.frame.width - paddingSpaceLeft
        let availableHeight = view.frame.height - paddingSpaceTop
        
        //Получаем высоту и ширину каждого элемента коллекции
        let heightRow = availableHeight / amountOfRows
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: heightRow)
//        Данная функция позволяет играть на любых экранах
    }
}
extension MatchGameViewController: UICollectionViewDataSource, UICollectionViewDelegate  {
    
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
        
        //Если карта не перевернута и не совпавшая, то можно ее перевернуть
        if !(card.isFlipped && card.isMatched){
            
            cell.flipCard()
            card.isFlipped = true
            
            // Звук переворота карты
            SoundManager.playSound(.flip)
            
            // Если это первая карта из 2-х, то присваиваем ей индекс из коллекции
            if firstFlippedCardIndex == nil {
                
                firstFlippedCardIndex = indexPath
                //  Если 2-я, проводим проверку на совпадение
            } else {
                checkForMatches(indexPath)
            }
        }
    }
}

//  MARK: REALM. Save data
extension MatchGameViewController {
    //    Запись информации об игре (Имя, результат)
    func savePlayersData() {
        let newScore = User(name: playersName, time: timer.counter, tries: tryCounter)
        RealmService.shared.create(newScore)
    }
}


