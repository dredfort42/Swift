//
//  ViewController.swift
//  MoarButtons
//
//  Created by Dmitry Novikov on 10.08.2022.
//

import UIKit

class ViewController: UIViewController {

	var clc = Calculator()

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.

		view.backgroundColor = UIColor.systemGray
		resetButtonView()
	}

	@IBOutlet var numberButtonView: [UIButton]!
	@IBOutlet var actionButtonView: [UIButton]!
	@IBOutlet var spacerView: [UILabel]!
	@IBOutlet weak var displayView: UILabel!

	@IBAction func numberButtonAction(_ sender: UIButton) {
		clc.inputNumber(num: (Int(sender.titleLabel?.text ?? "ERROR") ?? 0))
		resetButtonView()
	}

	@IBAction func resultButtonAction(_ sender: UIButton) {
		clc.resultAction()
		resetButtonView()
	}

	@IBAction func plusButtonAction(_ sender: UIButton) {
		clc.plusAction()
		resetButtonView()
	}

	@IBAction func minusButtonAction(_ sender: UIButton) {
		clc.minusAction()
		resetButtonView()
	}

	@IBAction func multiplicationButtonAction(_ sender: UIButton) {
		clc.multiplicationAction()
		resetButtonView()
	}

	@IBAction func divisionButtonAction(_ sender: UIButton) {
		clc.divisionAction()
		resetButtonView()
	}

	@IBAction func acButtonAction(_ sender: UIButton) {
		clc = Calculator()
		resetButtonView()
	}

	@IBAction func negButtonAction(_ sender: UIButton) {
		clc.number *= -1
		resetButtonView()
	}


	func resetButtonView() {
		displayView.textColor = UIColor.black
		displayView.textAlignment = .right
		displayView.text = clc.displayDigits

		for button in numberButtonView {
			button.titleLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: .bold)
			button.titleLabel?.textColor = UIColor.black
			button.backgroundColor = UIColor.lightGray
			button.layer.cornerRadius = 5
			button.layer.borderColor = UIColor.gray.cgColor
			button.layer.borderWidth = 2
		}

		for button in actionButtonView {
			button.titleLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: .bold)
			button.titleLabel?.textColor = UIColor.white
			button.backgroundColor = UIColor.orange
			button.layer.cornerRadius = 5
			button.layer.borderColor =  UIColor.systemOrange.cgColor
			button.layer.borderWidth = 2

		}

		for spacer in spacerView {
			spacer.textColor = UIColor.clear
		}
	}
}

