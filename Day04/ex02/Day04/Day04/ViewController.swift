//
//  ViewController.swift
//  Day04
//
//  Created by Dmitry Novikov on 14.08.2022.
//

import UIKit

class ViewController: UIViewController, APITwitterDelegate {


	var token: String? = OAuch2().getToken()
	var tweets: [Tweet] = []
	var query: String = "School"

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		while token == nil {}
		print(token!)
		APIController(delegate: self, token: token!).getTweets(query: self.query)
	}

	func getTweets(tweets: [Tweet]) {

	}

	func showErrors(error: NSError) {

	}

}

