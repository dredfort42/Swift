//
//  Tweet.swift
//  Day04
//
//  Created by Dmitry Novikov on 14.08.2022.
//

import Foundation

struct Tweet: CustomStringConvertible {
	let name : String
	let text : String
	
	var description: String {
		return ("Name: \(name)\nText: \(text)")
	}

}
