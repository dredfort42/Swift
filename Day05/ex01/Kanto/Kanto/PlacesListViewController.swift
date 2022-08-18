//
//  PlacesTabelViewController.swift
//  Kanto
//
//  Created by Dmitry Novikov on 18.08.2022.
//

import UIKit

class PlacesListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

	var placesList = PlacesList().places

	@IBOutlet weak var placesListView: UITableView! {
		didSet {
			placesListView.delegate = self
			placesListView.dataSource = self
		}
	}

	override func viewDidLoad() {
        super.viewDidLoad()
        print(placesList)
    }

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return placesList.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "PlacesListCell")
		cell?.textLabel?.text = placesList[indexPath.row].name
		return cell ?? UITableViewCell()
	}

}
