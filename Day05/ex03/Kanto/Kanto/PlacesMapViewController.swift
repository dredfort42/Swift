//
//  PlacesMapViewController.swift
//  Kanto
//
//  Created by Dmitry Novikov on 18.08.2022.
//

import UIKit
import MapKit

class PlacesMapViewController: UIViewController, MKMapViewDelegate {

	@IBOutlet weak var placesMapView: MKMapView! {
		didSet {
			placesMapView.delegate = self
		}
	}
	@IBOutlet weak var mapViewControlView: UISegmentedControl!
	
	@IBAction func mapViewControlAction(_ sender: UISegmentedControl) {
		switch (mapViewControlView.selectedSegmentIndex) {
			case 1:
				placesMapView.mapType = MKMapType.satellite
			case 2:
				placesMapView.mapType = MKMapType.hybrid
			default:
				placesMapView.mapType = MKMapType.standard
		}
	}

	override func viewDidLoad() {
        super.viewDidLoad()

		placesMapView.isZoomEnabled = true
		placesMapView.addAnnotations(PlacesList.places)
		showPlace(place: PlacesList.places.first!)

    }

	func showPlace(place: MKAnnotation) {
		var region = MKCoordinateRegion()
		region.center = place.coordinate
		region.span.latitudeDelta = 0.01;
		region.span.longitudeDelta = 0.01;
		placesMapView.setRegion(region, animated: true)
	}
	
}
