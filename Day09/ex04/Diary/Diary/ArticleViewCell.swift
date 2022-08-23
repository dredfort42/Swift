//
//  ArticleViewCell.swift
//  Diary
//
//  Created by Dmitry Novikov on 23.08.2022.
//

import UIKit

class ArticleViewCell: UITableViewCell {

	@IBOutlet weak var articleImageView: UIImageView!
	@IBOutlet weak var contentLabel: UILabel!

	@IBOutlet weak var creationImageView: UIImageView!
	@IBOutlet weak var creationDateLabel: UILabel!

	@IBOutlet weak var modificationImageView: UIImageView!
	@IBOutlet weak var modificationDateLabel: UILabel!

	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
