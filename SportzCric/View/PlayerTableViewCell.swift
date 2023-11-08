//
//  PlayerTableViewCell.swift
//  SportzCric
//
//  Created by Smollan Karan on 08/11/23.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {

    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var playerNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.playerView.layer.cornerRadius = 10
        self.playerView.layer.borderWidth = 1
        self.playerView.layer.borderColor = UIColor.black.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    
}
