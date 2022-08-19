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
		handleGestures(element: element)
	}

	func applyPhysics(element: UIView) {
		gravity.addItem(element)
		collision.addItem(element)
		itemBehaviour.addItem(element)
	}

	@objc func panGesture(_ sender: UIPanGestureRecognizer) {
		guard let element = sender.view else {
			print("PAN ACTION ERROR")
			return
		}

		switch sender.state {
			case .began:
				gravity.removeItem(element)
			case .changed:
				element.center = sender.location(in: self.view)
				dynamicAnimator.updateItem(usingCurrentState: element)
			case .ended:
				gravity.addItem(element)

			default:
				break
		}
	}

	@objc func pinchGesture(_ sender: UIPinchGestureRecognizer) {
		guard let element = sender.view else {
			print("PICH ACTION ERROR")
			return
		}

		switch sender.state {
			case .began:
				gravity.removeItem(element)
			case .changed:
				element.bounds.size.width *= sender.scale
				element.bounds.size.height *= sender.scale
				if element.layer.cornerRadius != 0 {
					element.layer.cornerRadius *= sender.scale
				}
				sender.scale = 1
				dynamicAnimator.updateItem(usingCurrentState: element)
			case .ended:
				gravity.addItem(element)

			default:
				break
		}
	}

	@objc func rotationGesture(_ sender: UIRotationGestureRecognizer) {
		guard let element = sender.view else {
			print("ROTATION ACTION ERROR")
			return
		}

		switch sender.state {
			case .began:
				gravity.removeItem(element)
			case .changed:
				element.transform = CGAffineTransform(rotationAngle: sender.rotation)
				dynamicAnimator.updateItem(usingCurrentState: element)
			case .ended:
				gravity.addItem(element)

			default:
				break
		}
	}

	func handleGestures(element: UIView) {
		let panGesture = UIPanGestureRecognizer(
			target: self,
			action: #selector(ViewController.panGesture(_ :))
		)
		element.addGestureRecognizer(panGesture)
		let pinchGesture = UIPinchGestureRecognizer(
			target: self,
			action: #selector(ViewController.pinchGesture(_ :))
		)
		element.addGestureRecognizer(pinchGesture)
		let rotationGesture = UIRotationGestureRecognizer(
			target: self,
			action: #selector(ViewController.rotationGesture(_ :))
		)
		element.addGestureRecognizer(rotationGesture)
	}
}

