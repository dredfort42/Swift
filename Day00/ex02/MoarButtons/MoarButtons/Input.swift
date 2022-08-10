//
//  Input.swift
//  MoarButtons
//
//  Created by Dmitry Novikov on 10.08.2022.
//

import Foundation

class Calculator {
	var number : Int = 0

	func input(num : Int) {
		number *= 10
		number += num
	}
}
