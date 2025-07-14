//
//  ProgramTableViewCell.swift
//  FitnessApp
//
//  Created by mac on 7/15/25.
//

import UIKit

class ProgramTableViewCell: UITableViewCell {

    static let identifer = "ProgramTableViewCell"
    
    @IBOutlet weak var titleLabel   : UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let gradientLayer = CAGradientLayer()
        
        let colorTop    = UIColor.primary  .cgColor
        let colorBottom = UIColor.secondary.cgColor
        
        gradientLayer.colors        = [colorTop, colorBottom]
        gradientLayer.locations     = [0.0, 1.0]
        gradientLayer.bounds        = containerView.bounds
        gradientLayer.cornerRadius  = 8
        containerView.layer.insertSublayer(gradientLayer, at: 0)
        containerView.clipsToBounds = true
        
        titleLabel   .font = UIFont.style(.h1)
        durationLabel.font = UIFont.style(.caption)
        caloriesLabel.font = UIFont.style(.caption)
        
        selectionStyle     = .none
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.layer.cornerRadius = 8
    }

    
}
