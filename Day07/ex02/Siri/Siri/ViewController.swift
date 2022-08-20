//
//  ViewController.swift
//  Siri
//
//  Created by Dmitry Novikov on 20.08.2022.
//

import UIKit
import RecastAI

class ViewController: UIViewController {

	var bot : RecastAIClient?

	@IBOutlet weak var answerLabel: UILabel!
	@IBOutlet weak var requestField: UITextField!
	@IBAction func sendButtonAction(_ sender: UIButton) {
		if requestField.text != nil {
			make(request: requestField.text!)
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		self.bot = RecastAIClient(token : "c80f802ac6dd241654df237385b351b5", language: "en")
		answerLabel.text = "Enter city"
	}

	func make(request: String){
		bot?.textRequest(request, successHandler: { (response) in
			if let locations = response.all(entity: "location") {
				let coordinates = (locations[0]["formatted"] as? String, locations[0]["lat"]?.doubleValue, locations[0]["lng"]?.doubleValue)
				self.answerLabel.text = "\(coordinates.0!)\nLAT: \(coordinates.1!)\nLNG: \(coordinates.2!)"
			} else {
				self.answerLabel.text = "Enter a valid city"
			}
		}, failureHandle: { (error) in
			self.answerLabel.text = "Error"
		})
	}
}

