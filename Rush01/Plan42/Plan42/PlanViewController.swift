//
//  ViewController.swift
//  Plan42
//
//  Created by Dmitry Novikov on 24.08.2022.
//

import UIKit
import GoogleMaps
import GooglePlaces

class PlanViewController: UIViewController, CLLocationManagerDelegate {
	let locationManager = CLLocationManager()
	let placesClient = GMSPlacesClient()

	var trackingIsOn: Bool = true

	let autocompleteSessionToken = GMSAutocompleteSessionToken.init()
	var autocompletePredictions: [GMSAutocompletePrediction] = [] {
		didSet {
			if autocompletePredictions.count > 0 {
				predictionsTableView.isHidden = false
			} else {
				predictionsTableView.isHidden = true
			}
		}
	}

	var addressA: GMSPlace?
	var addressB: GMSPlace?


	@IBOutlet weak var mapView: GMSMapView!
	@IBAction func mapViewSegmentationControlAction(_ sender: UISegmentedControl) {
		switch sender.selectedSegmentIndex {
			case 0:
				mapView.mapType = .normal
			case 1:
				mapView.mapType = .satellite
			default:
				mapView.mapType = .terrain
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

	@IBOutlet weak var routeButtonView: UIButton!
	@IBAction func routeButtonAction(_ sender: UIButton) {
	}

	@IBOutlet weak var searchButtonView: UIButton!
	@IBAction func searchButtonAction(_ sender: UIButton) {
		if routeStackView.isHidden {
			routeStackView.isHidden = false
		} else {
			routeStackView.isHidden = true
		}
		updateSearchButtonViev()
	}

	@IBOutlet weak var routeStackView: UIStackView!
	@IBOutlet weak var addressATextField: UITextField! {
		didSet {
			addressATextField.delegate = self
			addressATextField.layer.borderColor = UIColor.systemGray5.cgColor
		}
	}
	@IBOutlet weak var predictionsTableView: UITableView! {
		didSet {
			predictionsTableView.delegate = self
			predictionsTableView.dataSource = self
			predictionsTableView.layer.cornerRadius = 6
			predictionsTableView.layer.borderWidth = 1
			predictionsTableView.layer.borderColor = UIColor.systemGray5.cgColor
		}
	}

	@IBAction func showAddressButtonAction(_ sender: UIButton) {
		if addressA != nil && addressB == nil {
			getMarker(
				titleMarker: (addressA?.formattedAddress)!,
				latitude: (addressA?.coordinate.latitude)!,
				longitude: (addressA?.coordinate.longitude)!
			)
			mapView.camera = GMSCameraPosition(latitude:  (addressA?.coordinate.latitude)!, longitude: (addressA?.coordinate.longitude)!, zoom: 15)
		}
		addressATextField.endEditing(true)
		routeStackView.isHidden = true
		trackingButtonAction(UIButton())
		updateSearchButtonViev()
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.

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
		locationManager.startUpdatingLocation()

		mapView.isMyLocationEnabled = true
		mapView.settings.allowScrollGesturesDuringRotateOrZoom = true
		mapView.mapType = .normal

		routeStackView.isHidden = true
		predictionsTableView.isHidden = true

		updateTrackingButtonViev()
		updateRouteButtonView()
		updateSearchButtonViev()
	}

	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		guard let coordinate = manager.location?.coordinate else {
			return
		}
		mapView.camera = GMSCameraPosition.camera(
			withLatitude: coordinate.latitude,
			longitude: coordinate.longitude,
			zoom: 15.0
		)
	}

	func updateTrackingButtonViev() {
		if trackingIsOn {
			trackingButtonView.tintColor = .systemBlue
		} else {
			trackingButtonView.tintColor = .systemGray
		}
	}

	func updateRouteButtonView() {
		routeButtonView.isHidden = true
		routeButtonView.tintColor = .systemGray
	}

	func updateSearchButtonViev() {
		if routeStackView.isHidden {
			searchButtonView.tintColor = . systemGray
		} else {
			searchButtonView.tintColor = .systemBlue
		}
	}

	func getMarker(titleMarker: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
		let marker = GMSMarker()
		marker.position = CLLocationCoordinate2DMake(latitude, longitude)
		marker.title = titleMarker
		marker.map = mapView
	}

}
