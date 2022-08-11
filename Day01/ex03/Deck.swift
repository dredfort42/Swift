//
//  Deck.swift
//  
//
//  Created by Dmitry Novikov on 11.08.2022.
//

import Foundation

class Deck : NSObject {
	static let allSpades : [Card] = Value.allValues.map({Card(color: .pikes, value: $0)})
	static let allDiamonds : [Card] = Value.allValues.map({Card(color: .diamonds, value: $0)})
	static let allHearts : [Card] = Value.allValues.map({Card(color: .hearts, value: $0)})
	static let allClubs : [Card] = Value.allValues.map({Card(color: .clubs, value: $0)})
	static let allCards : [Card] = allSpades + allDiamonds + allHearts + allClubs
}
