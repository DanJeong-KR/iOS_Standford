

// 카드 덱을 나타냄

import Foundation

struct PlayingCard
{
    // 카드에 필요한게 두개
    var suit: Suit  // 문양
    var rang: Rank  // 숫자
    
    enum Suit: String {
        case spades = "♠️"
        case hearts = "♥️"
        case diamonds = "♦️"
        case clubs = "♣️"
        
        // 모든 것을 가져올 것이므로 static 써야지
        static var all = [Suit.spades, .hearts, .diamonds, .clubs]
    }
    
    enum Rank {
        case ace // A
        case face(String) // J Q K
        case numeric(pipsCount: Int) // 2,3,4.. 숫자
        
        var order: Int {
            switch self {
            case .ace: return 1
            case .numeric(pipsCount: let pips): return pips
            case .face(let kind) where kind == "J": return 11
            case .face(let kind) where kind == "Q": return 12
            case .face(let kind) where kind == "K": return 13
            default: return 0 // 모든 가능성을 체크한 것 같지만 where 키워드는 모든것을 체크하지 않으므로 default 를 사용했다.
            }
        }
        
        static var all: [Rank] {
            var allRanks = [Rank.ace]
            
            for pips in 2...10 {
                allRanks.append(Rank.numeric(pipsCount: pips))
            }
            allRanks += [Rank.face("J"),.face("Q"),.face("K")]
            return allRanks
        }
    }
}
