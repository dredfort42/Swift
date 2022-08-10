//
//  Calculator.swift
//  MoarButtons
//
//  Created by Dmitry Novikov on 10.08.2022.
//

import Foundation

enum Operations {
	case plus
	case minus
	case multiplication
	case division
}

class Calculator {
	var number : Int = 0 {
		didSet {
			displayDigits = String(number)
		}
	}
	var result : Int = 0
	var displayDigits : String = "0"
	var operation = Operations.plus

	func inputNumber(num : Int) {
		number *= 10
		number += num
	}

	func resultAction() {
		if operation == .division && number == 0 {
			number = 0
			result = 0
			displayDigits = "ERROR: DIVISION BY ZERO"
		} else {
			switch operation {
				case .plus:
					result += number
				case .minus:
					result -= number
				case .multiplication:
					result *= number
				case .division:
					result /= number
			}
			number = 0
			displayDigits = String(result)
		}
	}

	func plusAction() {
		resultAction()
		operation = .plus
		number = 0
		displayDigits = String(result)
	}

	func minusAction() {
		resultAction()
		operation = .minus
		number = 0
		displayDigits = String(result)
	}

	func multiplicationAction() {
		resultAction()
		operation = .multiplication
		number = 0
		displayDigits = String(result)
	}

	func divisionAction() {
		resultAction()
		operation = .division
		number = 0
		displayDigits = String(result)
	}
}
