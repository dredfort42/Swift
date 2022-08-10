//
//  ViewController.swift
//  SupersizeMe
//
//  Created by Dmitry Novikov on 10.08.2022.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		testLabel.isHidden = true
	}

	@IBOutlet weak var testLabel: UILabel!

	@IBAction func clickButton(_ sender: UIButton) {
		testLabel.isHidden = !testLabel.isHidden
	}
}

