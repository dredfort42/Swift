//
//  Model.swift
//  Day03
//
//  Created by Dmitry Novikov on 13.08.2022.
//

import Foundation
import UIKit

class Model {
	static let images: [URL?] = [
		URL(string: "https://mars.nasa.gov/system/resources/detail_files/26910_Curiosity_Poster-web.jpg"),
		URL(string: "https://mars.nasa.gov/system/resources/detail_files/26895_PIA25326-web.jpg"),
		URL(string: "https://mars.nasa.gov/system/resources/detail_files/26715_PIA25233-web.jpg"),
		URL(string: "https://mars.nasa.gov/system/resources/detail_files/26717_PIA25234-web.jpg"),
		URL(string: "https://mars.nasa.gov/system/resources/detail_files/26694_1-PIA25219-web.jpg"),
		URL(string: "https://mars.nasa.gov/system/resources/detail_files/26617_PIA25171-web.jpg")
	]

	static func getImage(number: Int) -> UIImage? {
		var image: UIImage? = nil
		if number >= 0 && number < images.count {
			let data = try? Data(contentsOf: images[number]!)
			image = UIImage(data: data!)
		}
		return image
	}
}
