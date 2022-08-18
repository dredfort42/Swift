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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
