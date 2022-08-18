//
//  PlacesTabelViewController.swift
//  Kanto
//
//  Created by Dmitry Novikov on 18.08.2022.
//

import UIKit

class PlacesListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

	@IBOutlet weak var placesListView: UITableView! {
		didSet {
			placesListView.delegate = self
			placesListView.dataSource = self
		}
	}

	override func viewDidLoad() {
        super.viewDidLoad()
    }

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return PlacesList.places.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let place = PlacesList.places[indexPath.row]
		let cell = tableView.dequeueReusableCell(withIdentifier: "PlacesListCell")
		cell?.textLabel?.text = (place.title! ?? "Ups") + " – " + (place.subtitle! ?? "upS")
		return cell ?? UITableViewCell()
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		performSegue(withIdentifier: "showOnMap", sender: self)
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if  let indexPath = placesListView.indexPathForSelectedRow {
			let destinationView = segue.destination as! PlacesMapViewController
			destinationView.placeToShow = PlacesList.places[indexPath.row]
		}
	}

}
