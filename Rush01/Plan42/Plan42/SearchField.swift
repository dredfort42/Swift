//
//  SearchField.swift
//  Plan42
//
//  Created by Dmitry Novikov on 24.08.2022.
//

import UIKit

extension PlanViewController: UITextFieldDelegate {

	func textFieldDidBeginEditing(_ textField: UITextField) {
		autocompletePredictions = []
		predictionsTableView.reloadData()
	}

	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		showAddressButtonAction(UIButton())
		return true
	}

	func textFieldDidEndEditing(_ textField: UITextField) {
		predictionsTableView.reloadData()
	}

	func textFieldDidChangeSelection(_ textField: UITextField) {
		predictionsTableView.reloadData()
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
			sessionToken: autocompleteSessionToken
		) { (predications, erroe) in
			self.autocompletePredictions = predications ?? []
		}
		predictionsTableView.reloadData()
		return true
	}

}
