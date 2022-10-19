//
//  TestTableViewCell.swift
//  MacroTestAlgorithm
//
//  Created by Eldwin Anthony on 13/10/22.
//

import UIKit

class TestTableViewCell: UITableViewCell {
    
    @IBOutlet var departurestationLbl: UILabel!
    @IBOutlet var destinationstationLbl: UILabel!
    @IBOutlet var transitLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
