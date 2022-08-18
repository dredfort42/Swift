//
//  PlacesMapViewController.swift
//  Kanto
//
//  Created by Dmitry Novikov on 18.08.2022.
//

import UIKit
import MapKit

class PlacesMapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

	var locationManager = CLLocationManager()
	var trackingIsOn: Bool = false
	var placeToShow: MKAnnotation = PlacesList.places.first!

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

	@IBOutlet weak var trackingButtonView: UIButton!
	@IBAction func trackingButtonAction(_ sender: UIButton) {
		if !trackingIsOn {
			locationManager.startUpdatingLocation()
		} else {
			locationManager.stopUpdatingLocation()
		}
		trackingIsOn = !trackingIsOn
		updateTrackingButtonViev()
	}

	@IBAction func unwindToPlacesMapViewController(_ segue: UIStoryboardSegue) {
		showPlace(coordinate: placeToShow.coordinate)
	}

	override func viewDidLoad() {
        super.viewDidLoad()

		if CLLocationManager.locationServicesEnabled() {
			switch locationManager.authorizationStatus {
				case .notDetermined, .restricted, .denied:
					print("No access")
					locationManager.requestWhenInUseAuthorization()
				case .authorizedAlways, .authorizedWhenInUse:
					print("Access")
				@unknown default:
					break
			}
		} else {
			print("Location services are not enabled")
		}

		locationManager.delegate = self
		locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
		locationManager.distanceFilter = 10

		placesMapView.isZoomEnabled = true
		placesMapView.addAnnotations(PlacesList.places)
		showPlace(coordinate: placeToShow.coordinate)

		updateTrackingButtonViev()
    }

	func showPlace(coordinate: CLLocationCoordinate2D) {
		var region = MKCoordinateRegion()
		region.center = coordinate
		region.span.latitudeDelta = 0.01;
		region.span.longitudeDelta = 0.01;
		placesMapView.setRegion(region, animated: true)
	}

	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		guard let coordinate = manager.location?.coordinate else {
			return
		}
		showPlace(coordinate: coordinate)
	}

	func updateTrackingButtonViev() {
		trackingButtonView.backgroundColor = UIColor.white.withAlphaComponent(0.8)
		trackingButtonView.layer.borderWidth = 2
		trackingButtonView.layer.cornerRadius = trackingButtonView.frame.width / 2
		if trackingIsOn {
			trackingButtonView.tintColor = .systemBlue
			trackingButtonView.layer.borderColor = UIColor.systemBlue.cgColor
		} else {
			trackingButtonView.tintColor = .systemGray
			trackingButtonView.layer.borderColor = UIColor.systemGray.cgColor
		}
	}
}
