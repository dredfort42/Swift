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
	var trackingIsOn: Bool = true
	let placesClient = GMSPlacesClient()
	var autocompletePredictions: [GMSAutocompletePrediction] = [] {
		didSet {
			updatePredicationTableView()
		}
	}
	
	var addressA: GMSPlace? {
		didSet {
			updateAdressView()
		}
	}
	var addressB: GMSPlace? {
		didSet {
			updateAdressView()
		}
	}

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
			addressATextField.layer.borderWidth = 2
			addressATextField.layer.cornerRadius = 6
			addressATextField.layer.borderColor = UIColor.systemGray5.cgColor
		}
	}
	@IBOutlet weak var predictionsTableView: UITableView!
	@IBOutlet weak var showAddressButtonView: UIButton!
	@IBAction func showAddressButtonAction(_ sender: UIButton) {
		showAddress()
	}

	@IBOutlet weak var actionButtonsStackView: UIStackView!
	@IBOutlet weak var addAddressButtonView: UIButton!
	@IBAction func addAddressButtonAction(_ sender: UIButton) {
		if addressA != nil && addressB != nil {
			routeToTextField.text = ""
			addressB = nil
		} else {
			routeToTextField.text = addressATextField.text
			addressB = addressA
		}
		addressATextField.text = ""
		addressA = nil
	}

	@IBOutlet weak var routeToTextField: UITextField!

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

		actionButtonsStackView.isHidden = true
		routeToTextField.isHidden = true
		routeStackView.isHidden = true
		predictionsTableView.isHidden = true

		updateTrackingButtonViev()
		updateSearchButtonViev()
		updateAdressView()
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

	func getMarker(titleMarker: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
		let marker = GMSMarker()
		marker.position = CLLocationCoordinate2DMake(latitude, longitude)
		marker.title = titleMarker
		marker.map = mapView
	}

	func showAddress() {
		mapView.clear()
		addressATextField.endEditing(true)
		routeStackView.isHidden = true
		if trackingIsOn {
			trackingButtonAction(UIButton())
		}
		updateSearchButtonViev()
		if addressA != nil && addressB != nil {
			getPath(addressA: addressA!, addressB: addressB!)
		} else if (addressA != nil && addressB == nil) || (addressA == nil && addressB != nil) {
			let address = addressA != nil ? addressA : addressB
			getMarker(
				titleMarker: (address?.formattedAddress)!,
				latitude: (address?.coordinate.latitude)!,
				longitude: (address?.coordinate.longitude)!
			)
			mapView.camera = GMSCameraPosition(latitude:  (address?.coordinate.latitude)!, longitude: (address?.coordinate.longitude)!, zoom: 15)
		}
	}

	func updatePredicationTableView() {
		predictionsTableView.delegate = self
		predictionsTableView.dataSource = self
		predictionsTableView.reloadData()
		predictionsTableView.layer.cornerRadius = 6
		predictionsTableView.layer.borderWidth = 1
		predictionsTableView.layer.borderColor = UIColor.systemGray5.cgColor
		if autocompletePredictions.count > 0 && addressA == nil {
			predictionsTableView.isHidden = false
		} else {
			predictionsTableView.isHidden = true
		}
	}

	func updateAdressView() {
		if addressB == nil {
			showAddressButtonView.setTitle("Show", for: .normal)
			addAddressButtonView.setTitle("Add address", for: .normal)
			if addressA != nil {
				actionButtonsStackView.isHidden = false
			} else {
				actionButtonsStackView.isHidden = true
			}
			routeToTextField.isHidden = true
			addressATextField.layer.borderColor = UIColor.systemGray5.cgColor
		} else {
			if addressA != nil {
				showAddressButtonView.setTitle("Route", for: .normal)
				addAddressButtonView.setTitle("Clear", for: .normal)
			} else {
				showAddressButtonView.setTitle("Show", for: .normal)
				addAddressButtonView.setTitle("Add address", for: .normal)
			}
			actionButtonsStackView.isHidden = false
			routeToTextField.isHidden = false
			routeToTextField.layer.borderWidth = 2
			routeToTextField.layer.cornerRadius = 6
			routeToTextField.layer.borderColor = UIColor.systemRed.cgColor
			addressATextField.layer.borderColor = UIColor.systemGreen.cgColor
		}
	}

	func updateTrackingButtonViev() {
		if trackingIsOn {
			trackingButtonView.tintColor = .systemBlue
		} else {
			trackingButtonView.tintColor = .systemGray
		}
	}

	func updateSearchButtonViev() {
		if routeStackView.isHidden {
			searchButtonView.tintColor = . systemGray
		} else {
			searchButtonView.tintColor = .systemBlue
		}
	}

}
