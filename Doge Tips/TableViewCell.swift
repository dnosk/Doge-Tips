//
//  TableViewCell.swift
//  
//
//  Created by Daniel Noskin on 8/24/15.
//
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var tipPercentageLabel: UILabel!
    @IBOutlet weak var totalCostLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
