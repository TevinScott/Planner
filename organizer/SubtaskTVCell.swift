//
//  CustomTableCell.swift
//  organizer
//
//  Created by Tevin Scott on 1/11/17.
//  Copyright © 2017 Tevin Scott. All rights reserved.
//

import Foundation
import UIKit
class SubtaskTVCell: UITableViewCell{
    
    
    @IBOutlet weak var subtaskField: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
