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
	var number : Int = 0
	var result : Int = 0
	var displayDigits : String = "0"
	var operation = Operations.plus

	func isOverflow(num : Double) -> Bool {
		if (num > Double(Int.max) || num < Double(Int.min)) {
			number = 0
			result = 0
			operation = .plus
			displayDigits = "ERROR: OVERFLOW"
			return true
		} else {
			return false
		}
	}

	func inputNumber(num : Int) {
		if !isOverflow(num: Double(number) * 10 + Double(num)) {
			number *= 10
			number += num
			displayDigits = String(number)
		}
	}

	func resultAction() {
		if operation == .division && number == 0 {
			number = 0
			result = 0
			displayDigits = "ERROR: DIVISION BY ZERO"
		} else {
			switch operation {
				case .plus:
					if !isOverflow(num: Double(result) + Double(number)) {
						result += number
						displayDigits = String(result)
					}
				case .minus:
					if !isOverflow(num: Double(result) - Double(number)) {
						result -= number
						displayDigits = String(result)
					}
				case .multiplication:
					if !isOverflow(num: Double(result) * Double(number)) {
						result *= number
						displayDigits = String(result)
					}
				case .division:
					if !isOverflow(num: Double(result) / Double(number)) {
						result /= number
						displayDigits = String(result)
					}
			}
			number = 0
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
