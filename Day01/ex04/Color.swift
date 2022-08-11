//
//  Color.swift
//  
//
//  Created by Dmitry Novikov on 11.08.2022.
//

import Foundation

enum Color : String {
	case clubs = "clubs"
	case diamonds = "diamonds"
	case hearts = "hearts"
	case pikes = "pikes"

	static let allColors : [Color] = [.clubs, .diamonds, .hearts, .pikes]
}

//for color in Color.allColors {
//	print(color)
//}
