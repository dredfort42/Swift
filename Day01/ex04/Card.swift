//
//  Card.swift
//  
//
//  Created by Dmitry Novikov on 11.08.2022.
//

import Foundation

class Card : NSObject {
	var color : Color
	var value : Value

	init(color : Color, value : Value) {
		self.color = color
		self.value = value
	}

	override var description: String {
		return "\(value) of \(color)"
	}

	override func isEqual(_ object: Any?) -> Bool {
		if let object = object as? Card {
			return (color == object.color && value == object.value)
		}
		return false
	}

	static func == (lhs: Card, rhs: Card) -> Bool {
		return (lhs.color == rhs.color && lhs.value == rhs.value)
	}
}


