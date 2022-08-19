//
//  Shape.swift
//  MotionCube
//
//  Created by Dmitry Novikov on 19.08.2022.
//

import Foundation
import UIKit

enum Figure {
	case circle
	case square

	static let allFigures = [circle, square]
}

class Shape: UIView {
	private let color: UIColor = UIColor(
		red: CGFloat(CGFloat(arc4random_uniform(100)) / 100),
		green: CGFloat(CGFloat(arc4random_uniform(100)) / 100),
		blue: CGFloat(CGFloat(arc4random_uniform(100)) / 100),
		alpha: 1.0)
	private let figure = Figure.allFigures[Int(arc4random_uniform(UInt32(Figure.allFigures.count)))]
	static var size: CGSize = CGSize(width: 100.0, height: 100.0)

	override init(frame: CGRect) {
		super.init(frame:frame)
		layer.cornerRadius = figure == Figure.circle ? CGFloat(max(Shape.size.width, Shape.size.width) / 2) : 0
		backgroundColor = color
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
