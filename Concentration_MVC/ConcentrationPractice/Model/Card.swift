
import Foundation

struct Card
{
    var isFaceUp = false
    var isMatchUp = false
    var identifier: Int
    
    // Emoji 는 UI 에 관한 내용. Data 에 사용하지 않는다.
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
}
