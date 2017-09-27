//
//  ContatoTableViewCell.swift
//  ContatosIP67
//
//  Created by ios7245 on 27/09/17.
//  Copyright © 2017 fcrespo82. All rights reserved.
//

import UIKit

@IBDesignable
class ContatoTableViewCell: UITableViewCell {

    @IBInspectable
    @IBOutlet weak var titleLabel: UILabel!
    @IBInspectable
    @IBOutlet weak var customImageView: UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
