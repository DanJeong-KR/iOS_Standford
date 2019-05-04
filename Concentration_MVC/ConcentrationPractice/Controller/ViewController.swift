//
//  ViewController.swift
//  ConcentrationPractice
//
//  Created by chang sic jung on 04/05/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // lazy 를 이용해서 cardButtons 이 초기화 되고 Concentration 을 초기화 하도록 한다.
    lazy var game: Concentration = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    
    var flipCount = 0 {
        didSet { flipCountLabel.text = "Flips: \(self.flipCount)" }
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            
            game.chooseCard(at: cardNumber) // 데이터 모델에서 카드 선택했을 때 모두 처리.
            updateViewFromModel()
        }else {
            print("Choosen card was not in cardButtons")
        }
        
    }
    
    // 모델 데이터가 수정되서 View 가 수정된다.
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = .white
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatchUp ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.6982771754, blue: 0, alpha: 1)
            }
        }
    }
    
    // Emoji data 는 UI 관련이므로 Data 가 아닌 Controller 에서 가져온다.
    var emojiChoices = ["🎃", "👻", "🐶", "🐱", "🐭", "🐹"]
    
    var emoji = Dictionary<Int,String>() // identifier 에 대한 이모지 설정하기
    //
    func emoji(for card: Card) -> String {
        
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex) // 중복 없도록 삭제
            
        }
        return emoji[card.identifier] ?? "?"
    }
    

}

