//
//  DetailedViewController.swift
//  Day03
//
//  Created by Dmitry Novikov on 14.08.2022.
//

import UIKit

class DetailedViewController: UIViewController, UIScrollViewDelegate {

	@IBOutlet weak var scrollView: UIScrollView!

	var detailedImageView: UIImageView!
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		scrollView.addSubview(detailedImageView)
		scrollView.contentSize = detailedImageView.frame.size
		scrollView.maximumZoomScale = 100
		scrollView.minimumZoomScale = 0.1
		setDefaultZoom()
    }

	override func viewWillLayoutSubviews() {
		setDefaultZoom()
	}

	func viewForZooming(in scrollView: UIScrollView) -> UIView? {
		return detailedImageView
	}

	func setDefaultZoom() {
		scrollView.zoomScale = self.view.bounds.size.width / detailedImageView!.bounds.size.width
	}
}
