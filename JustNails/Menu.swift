//
//  Menu.swift
//  JustNails
//
//  Created by Дмитрий on 15.08.16.
//  Copyright © 2016 Dmitry. All rights reserved.
//

import UIKit

class Menu {
    
    let title: String
    let image: UIImage?
    
    init(title: String, image: UIImage?) {
        self.title = title
        self.image = image
    }
    
    class func allPart() -> Array<Menu> {
        return [ Menu(title: "Home", image: UIImage(named: "Home")),
                 Menu(title: "Settings", image: UIImage(named: "Settings")),
                 Menu(title: "Maps", image: UIImage(named: "Maps"))]
    }
}