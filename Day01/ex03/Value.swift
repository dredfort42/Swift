//
//  Value.swift
//  
//
//  Created by Dmitry Novikov on 11.08.2022.
//

import Foundation

enum Value : Int {
	case ACE = 1
	case two = 2
	case three = 3
	case four = 4
	case five = 5
	case six = 6
	case seven = 7
	case eight = 8
	case nine = 9
	case ten = 10
	case JACK = 11
	case QUEEN = 12
	case KING = 13

	static let allValues : [Value] = [.ACE, .two, .three, .four, .five, .six, .seven, .eight, .nine, .ten, .JACK, .QUEEN, .KING]
}

//for value in Value.allValues {
//	print(value)
//}
