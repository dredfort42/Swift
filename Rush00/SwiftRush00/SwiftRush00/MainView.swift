//
//  MainView.swift
//  SwiftRush00
//
//  Created by Dmitry Novikov on 16.08.2022.
//

import UIKit
import WebKit

struct APIEvent: Decodable {
	var name: String?
	var description: String?
	var location: String?
	var kind: String?
	var max_people: Int?
	var nbr_subscribers: Int?
	var begin_at: String?
	var end_at: String?
}

class MainView: UIViewController, UITableViewDelegate, UITableViewDataSource {

	var events: [APIEvent] = []

	var reload: Bool = true {
		didSet {
			agendaView.reloadData()
		}
	}

	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var loginLabel: UILabel!
	@IBOutlet weak var levelLabel: UILabel!
	@IBOutlet weak var pictureView: UIImageView!

	@IBOutlet weak var agendaView: UITableView! {
		didSet {
			agendaView.delegate = self
			agendaView.dataSource = self
		}
	}
	
	@IBAction func logOutAction(_ sender: UIButton) {
		DispatchQueue.main.async {
			let dataStore = WKWebsiteDataStore.default()
			dataStore.fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { (records) in
				for record in records {
					dataStore.removeData(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(), for: [record], completionHandler: {})
				}
			}
		}
	}

	override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.


		updateUserView()
		print(OAuth.token)
		while OAuth.token.isEmpty {}
		getAgendaInformation()
    }

	private func getAgendaInformation() {
		var request = URLRequest(url: URL(string: "https://api.intra.42.fr/v2/events")!)
		request.httpMethod = "GET"
		request.setValue("Bearer " + OAuth.token, forHTTPHeaderField: "Authorization")

		let getData = URLSession.shared.dataTask(with: request) {
			(data, response, error) in
			if error != nil {
				print("GET AGENDA INFORMATION ERROR")
			} else if data != nil {
				do {
					let agenda: [APIEvent] = try JSONDecoder().decode([APIEvent].self, from: data!)
					for event in 0..<agenda.count {
						self.events.append(APIEvent(
							name: agenda[event].name,
							description: agenda[event].description,
							location: agenda[event].location,
							kind: agenda[event].kind,
							max_people: agenda[event].max_people,
							nbr_subscribers: agenda[event].nbr_subscribers,
							begin_at: agenda[event].begin_at,
							end_at: agenda[event].end_at))
						print("\n\n\n\n\n")
						print(self.events[event])
						print("\n\n\n\n\n")
					}
				} catch {
					print("AGENDA DECODING ERROR")
				}
			}
		}
		getData.resume()
//		print("\n\n\n\n\n")
//		print(tmpAgenda)
//		print("\n\n\n\n\n")

	}

	func updateUserView() {
		
		DispatchQueue.main.async {
			while User.name.isEmpty || User.surname.isEmpty {}
			self.nameLabel.text = User.name + " " + User.surname
		}
		DispatchQueue.main.async {
			while User.login.isEmpty {}
			self.loginLabel.text = User.login
		}
		DispatchQueue.main.async {
			while User.level.isEmpty {}
			self.levelLabel.text = "Level: " + User.level
		}
		DispatchQueue.main.async {
			while User.picture.isEmpty {}
			let data = try? Data(contentsOf: URL(string: User.picture)!)
			if data != nil {
				self.pictureView.image = UIImage(data: data!)
			}
		}
		pictureView.layer.cornerRadius = pictureView.frame.width / 2
		pictureView.layer.borderWidth = 1.0
		pictureView.layer.borderColor = UIColor.lightGray.cgColor

	}

	func numberOfSections(in tableView: UITableView) -> Int {
		return events.count
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
			return 1
		}

	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width - 40, height: 30))
		let label = UILabel()
		label.frame = CGRect.init(x: 20, y: 0, width: headerView.frame.width - 20, height: headerView.frame.height)
		label.font = .systemFont(ofSize: 18.0, weight: .bold)
		label.text = events[section].name
		label.textColor = .black
		headerView.addSubview(label)

		return headerView
	}

	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 30.0
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "AgendaTableViewCell") as! AgendaTableViewCell
		cell.nameLabel.text = events[indexPath.section].name
		cell.descriptionLabel.text = events[indexPath.section].description
		cell.maxGuestsLabel.text = events[indexPath.section].max_people?.description
		cell.currentGuestsLabel.text = events[indexPath.section].nbr_subscribers?.description
		cell.localizationLabel.text = events[indexPath.section].location
		cell.typeLabel.text = events[indexPath.section].kind
//		cell.durationLabel.text = events[indexPath.section].kind
		cell.startingTimeLabel.text = events[indexPath.section].begin_at
		cell.endTimeLabel.text = events[indexPath.section].end_at
		cell.layer.cornerRadius = 10
		if (events[indexPath.section].max_people ?? 0) - (events[indexPath.section].nbr_subscribers ?? 0) == 0 {
			cell.registerButton.isHidden = true
			cell.unregisterButton.isHidden = true
		}
		return cell

	}


}
