//
//  PredictionsTable.swift
//  Plan42
//
//  Created by Dmitry Novikov on 24.08.2022.
//

import UIKit

class PredictCell: UITableViewCell {
	@IBOutlet weak var predictLabetView: UILabel!
}

extension PlanViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return autocompletePredictions.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "PredictCell") as! PredictCell
		cell.predictLabetView.text = autocompletePredictions[indexPath.row].attributedFullText.string
		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.placesClient.lookUpPlaceID(
			self.autocompletePredictions[indexPath.row].placeID,
			callback: { (place, error) in
				if self.addressA == nil {
					self.addressATextField.text = self.autocompletePredictions[indexPath.row].attributedPrimaryText.string
					self.addressA = place
				} else {
					//				self.addressBTextField.text = self.autocompletePredictions[indexPath.row].attributedPrimaryText.string
					//				self.addressB = place
				}

			}
		)
		tableView.deselectRow(at: indexPath, animated: false)
		predictionsTableView.isHidden = true
	}
}


