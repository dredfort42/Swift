//
//  Deck.swift
//  
//
//  Created by Dmitry Novikov on 11.08.2022.
//

import Foundation

class Deck : NSObject {
	static let allSpades: [Card] = Value.allValues.map({Card(color: .pikes, value: $0)})
	static let allDiamonds: [Card] = Value.allValues.map({Card(color: .diamonds, value: $0)})
	static let allHearts: [Card] = Value.allValues.map({Card(color: .hearts, value: $0)})
	static let allClubs: [Card] = Value.allValues.map({Card(color: .clubs, value: $0)})
	static let allCards: [Card] = allSpades + allDiamonds + allHearts + allClubs

	var cards: [Card] = []
	var discards: [Card] = []
	var outs: [Card] = []

	init(isShuffled: Bool) {
		cards = Deck.allCards
		if isShuffled {
			cards.shuffle()
		}
	}

	override var description: String {
		return (cards.description)
	}

	func draw() -> Card? {
		let first : Card? = cards.first
		if first != nil {
			outs.append(first!)
			cards.remove(at: 0)
		}
		return first
	}

	func fold(cardToFold: Card) {
		var i: Int = 0
		for card in outs {
			if card == cardToFold {
				discards.append(card)
				outs.remove(at: i)
			}
			i += 1
		}
	}

}

extension Array {
	mutating func shuffle() {
		for i in 0 ..< self.count {
			self.swapAt(Int(arc4random_uniform(UInt32(self.count))), i)
		}
	}
}
