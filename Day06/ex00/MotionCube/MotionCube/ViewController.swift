//
//  ViewController.swift
//  MotionCube
//
//  Created by Dmitry Novikov on 19.08.2022.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}
	
	@IBAction func tapAction(_ sender: UITapGestureRecognizer) {
		let location = sender.location(in: view)
		let frame = CGRect(
			x: location.x - Shape.size.width / 2,
			y: location.y - Shape.size.height / 2,
			width: Shape.size.width,
			height: Shape.size.height)
		let element = Shape(frame: frame)
		element.isUserInteractionEnabled = true
		element.clipsToBounds = true
		view.addSubview(element)
	}
}

