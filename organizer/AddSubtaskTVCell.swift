//
//  CustomTableCell.swift
//  organizer
//
//  Created by Tevin Scott on 1/11/17.
//  Copyright © 2017 Tevin Scott. All rights reserved.
//

import Foundation
import UIKit
class AddSubtaskTVCell: UITableViewCell{
    @IBOutlet weak var addSTButton: UIButton!
    @IBOutlet weak var subtaskTitleField: UITextField!
    var addedToList : Bool = false;
    var isAlterAdded : Bool = false;
    @IBAction func addSubtask(_ sender: Any) {
        if(subtaskTitleField.text!.characters.count > 0){
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addSTButton.setImage(UIImage(named: "light check"), for: .normal)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
