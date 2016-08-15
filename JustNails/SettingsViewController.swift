//
//  SettingsViewController.swift
//  JustNails
//
//  Created by Дмитрий on 15.08.16.
//  Copyright © 2016 Dmitry. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var delegate: MainViewControllerDelegate?
    
    @IBAction func showLeftPanel(sender: AnyObject) {
        delegate?.toggleLeftPanel?()
    }
}
