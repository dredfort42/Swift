//
//  DiaryViewController.swift
//  Diary
//
//  Created by Dmitry Novikov on 23.08.2022.
//

import UIKit
import dredfort2022

class Articles {
	static let manager = ArticleManager()
}

class DiaryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

	@IBOutlet weak var diaryTableView: UITableView! {
		didSet {
			diaryTableView.delegate = self
			diaryTableView.dataSource = self
		}
	}

	var articles: [Article] = []

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.

		addTestContent()

		guard let preferredLanguage = Locale.preferredLanguages.first else {
			return
		}
		articles = Articles.manager.getArticles(withLang: preferredLanguage)
		if articles.count > 1 {
			articles.sort{ $0.modificationDate! > $1.modificationDate! }
		}
	}

	func numberOfSections(in tableView: UITableView) -> Int {
		return articles.count
	}

	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width - 40, height: 30))
		let label = UILabel()
		label.frame = CGRect.init(x: 20, y: 0, width: headerView.frame.width - 20, height: headerView.frame.height)
		label.font = .systemFont(ofSize: 18.0, weight: .bold)
		label.text = articles[section].title
		label.textColor = .black
		headerView.addSubview(label)

		return headerView
	}

	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 30.0
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell") as! ArticleViewCell
		cell.imageView?.image = UIImage(data: articles[indexPath.section].image! as Data)
		cell.contentLabel.text = articles[indexPath.section].content
		cell.creationDateLabel.text = articles[indexPath.section].creationDate?.description
		if articles[indexPath.section].creationDate != articles[indexPath.section].modificationDate {
			cell.modificationDateLabel.text = articles[indexPath.section].modificationDate?.description
		} else {
			cell.modificationDateLabel.isHidden = true
			cell.modificationImageView.isHidden = true
		}


		return cell
	}

	func addTestContent() {
		if articles.count == 0 {
			let manager = Articles.manager
			let newArticle = manager.newArticle()
			newArticle.title = "The ARC"
			newArticle.image = (UIImage(named: "TheArc")?.jpegData(compressionQuality: 1.0))! as Data
			newArticle.content = "Can you curate your soulmate? Thirty-five-year-old Ursula Byrne, VP of Strategic Audacity at a branding agency in Manhattan, is successful, witty, whip-smart, and single. She's tried all the dating apps, and let's just say: she's underwhelmed by her options. You'd think that by now someone would have come up with something more bespoke; a way for users to be more tailored about who and what they want in a life partner--how hard could that be?\nEnter The Arc: a highly secretive, super-sophisticated matchmaking service that uses a complex series of emotional, psychological and physiological assessments to architect partnerships that will go the distance. The price tag is high, the promise ambitious--a level of lifelong compatibility that would otherwise be unattainable. In other words, The Arc will find your ideal mate.\nUrsula is paired with forty-two-year-old lawyer Rafael Banks. From moment one, this feels like the electric, lasting love they've each been seeking their whole adult lives. But as their relationship unfolds in unanticipated ways, the two begin to realize that true love is never a sure thing. And the arc of a relationship is never predictable...even when it's fully optimized."
			newArticle.creationDate = Date()
			newArticle.modificationDate = Date()
			newArticle.language = Locale.preferredLanguages.first!
			manager.save()
		}
	}

}
