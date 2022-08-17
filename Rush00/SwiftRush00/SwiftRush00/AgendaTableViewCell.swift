//
//  AgendaTableViewCell.swift
//  SwiftRush00
//
//  Created by Dmitry Novikov on 17.08.2022.
//

import UIKit

class AgendaTableViewCell: UITableViewCell {

	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var maxGuestsLabel: UILabel!
	@IBOutlet weak var currentGuestsLabel: UILabel!
	@IBOutlet weak var localizationLabel: UILabel!
	@IBOutlet weak var typeLabel: UILabel!
	@IBOutlet weak var durationLabel: UILabel!
	@IBOutlet weak var startingTimeLabel: UILabel!
	@IBOutlet weak var endTimeLabel: UILabel!

	@IBOutlet weak var registerButton: UIButton!
	@IBOutlet weak var unregisterButton: UIButton!

	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
