//
//  Places.swift
//  Kanto
//
//  Created by Dmitry Novikov on 18.08.2022.
//

import Foundation

struct Place {
	var name: String
}

class PlacesList {
	var places: [Place] = []

	init() {
		places.append(Place(name: "School 21"))
		places.append(Place(name: "42 – Paris Campus"))
		places.append(Place(name: "42 – Lyon Campus"))
		places.append(Place(name: "42 – Wolfsburg Campus"))
	}
}
