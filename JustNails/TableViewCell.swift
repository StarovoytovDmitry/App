//
//  TableViewCell.swift
//  JustNails
//
//  Created by Дмитрий on 19.08.16.
//  Copyright © 2016 Dmitry. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewCell: UIImageView!
    @IBOutlet weak var labelCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureForMenu(menu: Menu) {
        imageViewCell.image = menu.image
        labelCell.text = menu.title
    }
    
}
