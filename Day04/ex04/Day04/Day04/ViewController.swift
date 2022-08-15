//
//  ViewController.swift
//  Day04
//
//  Created by Dmitry Novikov on 14.08.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate, APITwitterDelegate {

	@IBOutlet weak var tweetsTabelView: UITableView! {
		didSet {
			tweetsTabelView.delegate = self
			tweetsTabelView.dataSource = self
		}
	}
	
	@IBOutlet weak var seachBarView: UISearchBar! {
		didSet {
			seachBarView.delegate = self
		}
	}

	var token: String? = OAuch2().getToken()
	var tweets: [Tweet] = []
	var query: String = "School"

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		redrawView()
	}

	func numberOfSections(in tableView: UITableView) -> Int {
		return tweets.count
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}

	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width - 40, height: 30))
		let label = UILabel()
		label.frame = CGRect.init(x: 20, y: 0, width: headerView.frame.width - 20, height: headerView.frame.height)
		label.font = .systemFont(ofSize: 18.0, weight: .bold)
		label.text = tweets[section].name
		label.textColor = .black
		headerView.addSubview(label)

		return headerView
	}

	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 30.0
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "TweetTableViewCell") as! TweetTableViewCell
		cell.dateView.text = tweets[indexPath.section].date
		cell.textView.text = tweets[indexPath.section].text
		cell.layer.cornerRadius = 10

		return cell
	}

	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		query = searchText
	}

	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		redrawView()
		searchBar.endEditing(true)
		tweetsTabelView.reloadData()
	}

	func getTweets(tweets: [Tweet]) {
		self.tweets = tweets
		tweetsTabelView.reloadData()
	}

	func showErrors(error: NSError) {

	}

	func redrawView() {
		while token == nil {}
		tweets = APIController(delegate: self, token: token!).getTweets(query: self.query)
	}
}

