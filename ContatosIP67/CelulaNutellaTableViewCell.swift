//
//  CelulaNutellaTableViewCell.swift
//  ContatosIP67
//
//  Created by ios7245 on 27/09/17.
//  Copyright © 2017 fcrespo82. All rights reserved.
//

import UIKit

class CelulaNutellaTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var `switch`: UISwitch!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
