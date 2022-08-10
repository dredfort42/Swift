//
//  ViewController.swift
//  MoarButtons
//
//  Created by Dmitry Novikov on 10.08.2022.
//

import UIKit

class ViewController: UIViewController {

	var display : String = "HELLO"

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
		print(Int(sender.titleLabel?.text ?? "ERROR") ?? 0)
		display = sender.titleLabel?.text ?? "ERROR"
		resetButtonView()
	}
	@IBAction func actionButtonAction(_ sender: UIButton) {
		print(Int(sender.titleLabel?.text ?? "ERROR") ?? 0)
		display = sender.titleLabel?.text ?? "ERROR"
		resetButtonView()
	}

	func resetButtonView() {
		displayView.textColor = UIColor.black
		displayView.textAlignment = .right
		displayView.text = display

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

