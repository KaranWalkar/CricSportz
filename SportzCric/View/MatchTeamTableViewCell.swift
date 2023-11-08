//
//  MatchTeamTableViewCell.swift
//  SportzCric
//
//  Created by Smollan Karan on 07/11/23.
//

import UIKit

class MatchTeamTableViewCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var matchTypeLabel: UILabel!
    @IBOutlet weak var teamAwayLabel: UILabel!
    @IBOutlet weak var teamHomeLabel: UILabel!
    @IBOutlet weak var infoButton: UIButton!
    
    var tapClosure: (()->())?
    
    @IBAction func buttonAction(_ sender: UIButton) {
        tapClosure?()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.prepareCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepareCell() {
        self.backView.layer.cornerRadius = 5
        self.backView.layer.borderWidth = 1
        self.backView.layer.borderColor = UIColor.black.cgColor
    }
}
