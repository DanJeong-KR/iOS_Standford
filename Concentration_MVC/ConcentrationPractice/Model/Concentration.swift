
import Foundation

class Concentration
{
    private(set) var cards = Array<Card>() // 누구든 볼 수 잇지만 바꿀 수는 없다.
    
    // 한장의 카드만 앞면인 카드 인덱스
    // 다른 값으로부터 값이 얻어지므로 Computed Property 가 적절하다. (그렇지 않으면 동기화 문제등 여러가지 문제가 생길 가능성이 있고 신경써야하므로.)
    private var indexOfOneAndOnlyFaceUpCard: Int?  {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
            //return faceUpCardIndices.count == 1 ? faceUpCardIndices.first : nil
            // 카드를 모두 보고 앞면인 카드가 하나만 있으면 해당 index 를 가져오고
            // 그게 아니면 nil 로 빠지게 하는 로직.
//            var foundIndex: Int? // 옵셔널을 초기화 하지 않으면 항상 nil 로 초기화
//            for index in cards.indices {
//                if cards[index].isFaceUp {
//                    if foundIndex == nil {
//                        foundIndex = index
//                    }else {
//                        return nil
//                    }
//
//                }
//            }
//            return foundIndex
        }
        set {
            for index in cards.indices {
                // 내가 설정한 카드만 앞면이고 나머지는 모두 뒷면인 상태로 저장하는 것.
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    
    
    
    // 카드 몇개로 시작할 건지 초기화.
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards) 적어도 하나의 카드 쌍이 있어야 합니다.")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            
            cards += [card,card] // card 가 구조체이기 때문에
        }
        // TODO: shuffle
        cards.shuffle()
    }
    
    // 카드가 선택했을 때 생기는 일들 데이터 모델에서 모두 처리.
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index) 선택된 인덱스가 카드에 없습니다")
        
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
                //indexOfOneAndOnlyFaceUpCard = nil // 2장 뒤집혀 있으니.
            }else {
                // 카드가 안뒤집혀 있는 상태거나 두장 모두 뒤집혀 있는 상태
//                for flipDownIndex in cards.indices { // 모두 뒤집고 초기상태
//                    cards[flipDownIndex].isFaceUp = false
//                }
//                cards[index].isFaceUp = true // 내가 클릭한 카드만 앞면
                
                 // 계산 프로퍼티의 set 을 작성했기 때문에 위의 로직이 필요가 없어짐
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
        
    }
}


extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
