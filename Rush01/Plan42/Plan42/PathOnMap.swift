//
//  PathOnMap.swift
//  Plan42
//
//  Created by Dmitry Novikov on 25.08.2022.
//

import Foundation
import GoogleMaps
import GooglePlaces

extension PlanViewController: GMSMapViewDelegate {

	func getPath(addressA: GMSPlace, addressB: GMSPlace)
	{
		let coordinatesA = "\(addressA.coordinate.latitude),\(addressA.coordinate.longitude)"
		let coordinatesB = "\(addressB.coordinate.latitude),\(addressB.coordinate.longitude)"
		let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(coordinatesA)&destination=\(coordinatesB)&mode=driving&key=AIzaSyDuCofUuvYuYWUZplyQlGcYr90Fgo1Brss"
		let request = URLRequest(url: URL(string: url)!)
		let direction = URLSession.shared.dataTask(with: request) { (data, response, error) in
			if error != nil {
				print("ERROR")
				return
			} else if data != nil {
				do {
					let dictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
					let routes = dictionary["routes"] as? [NSDictionary]
					print(routes?.first ?? "")
					if routes != nil {
						for route in routes! {
							let routeOverviewPolyline = route["overview_polyline"] as? NSDictionary
							if routeOverviewPolyline != nil {
								var points = ""
								for (key, value) in routeOverviewPolyline! {
									if key as! String == "points" {
										points = value as! String
										DispatchQueue.main.async {
											let path = GMSPath(fromEncodedPath: points)
											let polyline = GMSPolyline(path: path)
											polyline.strokeWidth = 5
											polyline.strokeColor = .systemBlue
											polyline.map = self.mapView
											self.mapView.animate(with: GMSCameraUpdate.fit(GMSCoordinateBounds(path: path!)))
										}
									}
								}
							}
						}
					} else {
						print("ROUTE NOT FOUND")
					}
				} catch {
					print("ROUTE NOT FOUND")
					return
				}
			}
		}
		direction.resume()
	}
	
}
