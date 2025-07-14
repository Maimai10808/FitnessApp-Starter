//
//  ProgramTableViewCell.swift
//  FitnessApp
//
//  Created by mac on 7/15/25.
//

import UIKit

class ProgramTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel   : UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
