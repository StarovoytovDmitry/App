//
//  LeftPanel.swift
//  JustNails
//
//  Created by Дмитрий on 11.08.16.
//  Copyright © 2016 Dmitry. All rights reserved.
//

import UIKit

//@objc
protocol LeftMenuDelegate {
    func menuSelected(index: Int)
}

class LeftPanel: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var delegate: LeftMenuDelegate?
    var menu : Array<Menu>!
    
    struct TableView {
        struct CellIdentifiers {
            static let MenuCell = "MenuCell"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        
        let nib = UINib(nibName: "Cell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "Cell")
    }
}

// Mark: Table View Data Source

extension LeftPanel: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
        
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //let cell = tableView.dequeueReusableCellWithIdentifier(TableView.CellIdentifiers.MenuCell, forIndexPath: indexPath) as! MenuCell
        //cell.configureForMenu(menu[indexPath.row])
        let cell: TableViewCell = self.tableView.dequeueReusableCellWithIdentifier("Cell") as! TableViewCell
        cell.configureForMenu(menu[indexPath.row])
        return cell
    }
    
}

// Mark: Table View Delegate

extension LeftPanel: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        delegate?.menuSelected(indexPath.row)
    }
    
}
/*
class MenuCell: UITableViewCell {
    
    @IBOutlet weak var imageViewCell: UIImageView!
    @IBOutlet weak var imageNameCell: UILabel!
    
    func configureForMenu(menu: Menu) {
        imageViewCell.image = menu.image
        imageNameCell.text = menu.title
    }
}
*/
