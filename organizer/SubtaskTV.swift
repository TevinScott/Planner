//
//  AddSubtaskVC.swift
//  organizer
//
//  Created by Tevin Scott on 1/12/17.
//  Copyright © 2017 Tevin Scott. All rights reserved.
//

import Foundation
import UIKit
class SubtaskTV: UITableView, UITableViewDataSource, UITableViewDelegate {
    var subtaskList: [String] = ["test"]
    var hasSubtasks: Bool = false;
    //intializer
    override func awakeFromNib() {
        super.awakeFromNib()
        self.isScrollEnabled = false
        self.dataSource = self
        self.delegate = self
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : SubtaskTVCell
        cell = self.dequeueReusableCell(withIdentifier: "subtaskCell", for: indexPath) as! SubtaskTVCell
        cell.subtaskField.text = subtaskList[indexPath.row]
        return cell
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subtaskList.count
    }
    /*
     *controls the set of buttons in the subtask table
     *adds the new subtask if the subtask has not been added
     *otherwise removes the 
     */
    func checkButtonClicked(sender:UIButton) {
        //let buttonRow = sender.tag
        //let cellhandle : AddSubtaskTVCell =
          //  self.cellForRow(at: IndexPath(row: buttonRow, section: 0)) as! AddSubtaskTVCell
    }
}
