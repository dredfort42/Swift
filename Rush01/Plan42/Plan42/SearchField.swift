//
//  SearchField.swift
//  Plan42
//
//  Created by Dmitry Novikov on 24.08.2022.
//

import UIKit
import GooglePlaces

extension PlanViewController: UITextFieldDelegate {

	func textFieldDidBeginEditing(_ textField: UITextField) {
		autocompletePredictions = []
	}

	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		showAddressButtonAction(UIButton())
		return true
	}

	func textFieldShouldClear(_ textField: UITextField) -> Bool {
		addressA = nil
		return true
	}

	func textField(
		_ textField: UITextField,
		shouldChangeCharactersIn range: NSRange,
		replacementString string: String
	) -> Bool {
		placesClient.findAutocompletePredictions(
			fromQuery: textField.text!,
			filter: nil,
			sessionToken: GMSAutocompleteSessionToken.init()
		) { (predications, erroe) in
			self.autocompletePredictions = predications ?? []
		}
		return true
	}

}
