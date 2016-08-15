//
//  ViewController.swift
//  JustNails
//
//  Created by Дмитрий on 10.08.16.
//  Copyright © 2016 Dmitry. All rights reserved.
//

import UIKit

@objc
protocol MainViewControllerDelegate {
    optional func toggleLeftPanel()
    optional func collapseSidePanels()
}

class MainViewController: UIViewController {
    
    var delegate: MainViewControllerDelegate?
    
    @IBAction func showLeftPanel(sender: AnyObject) {
        delegate?.toggleLeftPanel?()
    }
    
}

//extension MainViewController
/*
extension MainViewController: LeftMenuDelegate {
    func animalSelected(menu: Menu) {
        delegate?.collapseSidePanels?()
    }
}
*/