//
//  AddNoteViewController.swift
//  Day02
//
//  Created by Dmitry Novikov on 13.08.2022.
//

import UIKit

class AddNoteViewController: UIViewController {

	@IBOutlet weak var nameField: UITextField!
	@IBOutlet weak var dateField: UIDatePicker!
	@IBOutlet weak var descriptionField: UITextView!

	@IBAction func doneNavigationBarButton(_ sender: UIBarButtonItem) {
		if !(nameField.text?.isEmpty ?? true){
			let format = DateFormatter()
			format.dateFormat = "dd MMMM yyyy"
			Data.notes.append((nameField.text!, format.string(from: dateField.date), descriptionField.text!))
			print(Data.notes.last?.0 ?? "", Data.notes.last?.1 ?? "", Data.notes.last?.2 ?? "")
		}
		performSegue(withIdentifier: "toNotesSegue", sender: self)
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		prepareView()
	}

	func prepareView() {
		nameField.layer.borderWidth = 1
		nameField.layer.borderColor = UIColor.lightGray.cgColor
		nameField.layer.cornerRadius = 10

		descriptionField.layer.borderWidth = 1
		descriptionField.layer.borderColor = UIColor.lightGray.cgColor
		descriptionField.layer.cornerRadius = 10

	}

}
