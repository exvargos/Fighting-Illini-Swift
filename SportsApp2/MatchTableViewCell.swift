//
//  MatchTableViewCell.swift
//  SportsApp2
//
//  Created by Matthew Liu on 11/4/15.
//
//

import UIKit

class MatchTableViewCell: UITableViewCell {

// MARK: Properties
	@IBOutlet weak var teamLogo: UIImageView!
	@IBOutlet weak var teamNameLabel: UILabel!
	@IBOutlet weak var locationLabel: UILabel!
	@IBOutlet weak var statusLabel: UILabel!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
