//
//  ViewController.swift
//  Siri
//
//  Created by Dmitry Novikov on 20.08.2022.
//

import UIKit
import RecastAI
import ForecastIO
import CoreLocation

class ViewController: UIViewController {

	var recast : RecastAIClient?
	var darkSky: DarkSkyClient?
	var locationCoordinates: CLLocationCoordinate2D? {
		didSet {
			getForcastFromDarkSky()
		}
	}
	var forcastText: String = "Enter city" {
		didSet {
			DispatchQueue.main.async {
				self.answerLabel.text = self.forcastText
			}
		}
	}

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

		answerLabel.text = forcastText
		self.recast = RecastAIClient(token : "c80f802ac6dd241654df237385b351b5", language: "en")
		self.darkSky = DarkSkyClient(apiKey: "2ac4b9753bab9108db8df8f8a3705537")
		darkSky?.units = .si
		darkSky?.language = .english
	}

	func make(request: String){
		recast?.textRequest(request, successHandler: { (response) in
			if let locations = response.all(entity: "location") {
				let coordinates = (locations[0]["formatted"] as? String, locations[0]["lat"]?.doubleValue, locations[0]["lng"]?.doubleValue)
				//self.answerLabel.text = "\(coordinates.0!)\nLAT: \(coordinates.1!)\nLNG:\(coordinates.2!)"

				self.locationCoordinates = CLLocationCoordinate2D(
					latitude: coordinates.1!,
					longitude: coordinates.2!
				)
			} else {
				self.answerLabel.text = "Enter a valid city"
			}
		}, failureHandle: { (error) in
			self.answerLabel.text = "Error"
		})
	}

	func getForcastFromDarkSky() {
		if locationCoordinates != nil {
			darkSky?.getForecast(location: locationCoordinates!) { result in
				switch result {
					case .success((let currentForecast, _)):
						self.forcastText = currentForecast.currently?.summary?.description ?? "Oups..."
					case .failure:
						self.forcastText = "ERROR"
				}
			}
		}
	}
}

