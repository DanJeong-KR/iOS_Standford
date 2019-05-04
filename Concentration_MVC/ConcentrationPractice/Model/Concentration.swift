
import Foundation

class Concentration
{
    var cards = Array<Card>()
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    // 한장의 카드만 앞면인 카드 인덱스
    
    // 카드 몇개로 시작할 건지 초기화.
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            
            cards += [card,card] // card 가 구조체이기 때문에
        }
        // TODO: shuffle
        cards.shuffle()
    }
    
    // 카드가 선택했을 때 생기는 일들 데이터 모델에서 모두 처리.
    func chooseCard(at index: Int) {
        
        if !cards[index].isMatchUp { // 매치되지 않은 카드를 선택했다면
            // 한장의 카드가 뒤집혀 있고, 내가 선택한 index 가 그 카드가 아닐 때
            // 카드가 match 됬는지 아닌지 확인.
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // 같은 카드 맞췄을 때
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatchUp = true
                    cards[index].isMatchUp = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil // 2장 뒤집혀 있으니.
            }else {
                // 카드가 안뒤집혀 있는 상태거나 두장 모두 뒤집혀 있는 상태
                for flipDownIndex in cards.indices { // 모두 뒤집고 초기상태
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true // 내가 클릭한 카드만 앞면
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
        
    }
}
