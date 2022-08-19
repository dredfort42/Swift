//
//  ViewController.swift
//  MotionCube
//
//  Created by Dmitry Novikov on 19.08.2022.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

	var dynamicAnimator = UIDynamicAnimator()
	var gravity = UIGravityBehavior()
	var collision = UICollisionBehavior()
	var itemBehaviour = UIDynamicItemBehavior()

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.

		dynamicAnimator = UIDynamicAnimator(referenceView: view)
		gravity = UIGravityBehavior(items: [])
		collision = UICollisionBehavior(items: [])
		itemBehaviour = UIDynamicItemBehavior(items: [])

		gravity.magnitude = 2.5
		collision.translatesReferenceBoundsIntoBoundary = true
		itemBehaviour.elasticity = 0.5

		dynamicAnimator.addBehavior(gravity)
		dynamicAnimator.addBehavior(collision)
		dynamicAnimator.addBehavior(itemBehaviour)
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

		applyPhysics(element: element)
	}

	func applyPhysics(element: UIView) {
		gravity.addItem(element)
		collision.addItem(element)
		itemBehaviour.addItem(element)
	}
}

