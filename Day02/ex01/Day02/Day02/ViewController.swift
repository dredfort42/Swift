//
//  ViewController.swift
//  Day02
//
//  Created by Dmitry Novikov on 12.08.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}

	@IBOutlet weak var notesTabelView: UITableView! {
		didSet {
			notesTabelView.delegate = self
			notesTabelView.dataSource = self
		}
	}

	func numberOfSections(in tableView: UITableView) -> Int {
		return Data.notes.count
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}

	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 1.0
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell") as! NoteCellView
		cell.nameLabel.text = Data.notes[indexPath.row].0
		cell.dateLabel.text = Data.notes[indexPath.row].1
		cell.listLabel.text = Data.notes[indexPath.row].2
		cell.layer.cornerRadius = 10

		return cell
	}
}

