//
//  ContainerViewController.swift
//  JustNails
//
//  Created by Дмитрий on 11.08.16.
//  Copyright © 2016 Dmitry. All rights reserved.
//

import UIKit
//import QuartzCore

enum SlideOutState {
    case BothCollapsed
    case LeftPanelExpanded
}

class ContainerViewController: UIViewController {
    
    var mainNavigationController: UINavigationController!
    var mainViewController: MainViewController!
    
    var currentState: SlideOutState = .BothCollapsed {
        didSet {
            let shouldShowShadow = currentState != .BothCollapsed
            showShadowForMainViewController(shouldShowShadow) // Show shadow
        }
    }
    
    var leftViewController: LeftPanel?
    
    let centerPanelExpandedOffset: CGFloat = 120
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainViewController = UIStoryboard.centerViewController()
        mainViewController.delegate = self
        
        mainNavigationController = UINavigationController(rootViewController: mainViewController)
        view.addSubview(mainNavigationController.view)
        addChildViewController(mainNavigationController)
        
        mainNavigationController.didMoveToParentViewController(self)
        
        // GestureRecognizer
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(ContainerViewController.handlePanGesture(_:)))
        mainNavigationController.view.addGestureRecognizer(panGestureRecognizer)
 
    }
    
}

extension ContainerViewController: MainViewControllerDelegate {
    
    func toggleLeftPanel() {
        let notAlreadyExpanded = (currentState != .LeftPanelExpanded)
        
        if notAlreadyExpanded {
            addLeftPanelViewController()
        }
        
        animateLeftPanel(notAlreadyExpanded)
    }
    
    func addLeftPanelViewController() {
        if (leftViewController == nil) {
            leftViewController = UIStoryboard.leftViewController()
            leftViewController!.menu = Menu.allPart()
            
            addChildLeftPanel(leftViewController!)
        }
    }
    
    func addChildLeftPanel(sidePanelController: LeftPanel) {
        //leftViewController.delegate = mainViewController
        
        view.insertSubview(sidePanelController.view, atIndex: 0)
        addChildViewController(sidePanelController)
        sidePanelController.didMoveToParentViewController(self)
    }
    
    func animateLeftPanel(shouldExpand: Bool) {
        if (shouldExpand) {
            currentState = .LeftPanelExpanded
            
            animateCenterPanelXPosition(CGRectGetWidth(mainNavigationController.view.frame) - centerPanelExpandedOffset)
        } else {
            animateCenterPanelXPosition(0) { finished in
                self.currentState = .BothCollapsed
                
                self.leftViewController!.view.removeFromSuperview()
                self.leftViewController = nil;
            }
        }
    }
    
    func animateCenterPanelXPosition(targetPosition: CGFloat, completion: ((Bool) -> Void)! = nil) {
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: {
            self.mainNavigationController.view.frame.origin.x = targetPosition
            }, completion: completion)
    }
    
    func showShadowForMainViewController(shouldShowShadow: Bool) {
        if (shouldShowShadow) {
            mainNavigationController.view.layer.shadowOpacity = 0.8
        } else {
            mainNavigationController.view.layer.shadowOpacity = 0.0
        }
    }
}

extension ContainerViewController: UIGestureRecognizerDelegate {
    // MARK: Gesture recognizer
    
    func handlePanGesture(recognizer: UIPanGestureRecognizer) {
        let gestureIsDraggingFromLeftToRight = (recognizer.velocityInView(view).x > 0)
        
        if (gestureIsDraggingFromLeftToRight) {
            switch(recognizer.state) {
            case .Began:
                if (currentState == .BothCollapsed) {
                    addLeftPanelViewController()
                    showShadowForMainViewController(true)
                }
            case .Changed:
                recognizer.view!.center.x = recognizer.view!.center.x + recognizer.translationInView(view).x
                recognizer.setTranslation(CGPointZero, inView: view)
            case .Ended:
                if (leftViewController != nil) {
                    // animate the side panel open or closed based on whether the view has moved more or less than halfway
                    let hasMovedGreaterThanHalfway = recognizer.view!.center.x > view.bounds.size.width
                    animateLeftPanel(hasMovedGreaterThanHalfway)
                }
            default:
                break
            }
        }
    }
}

private extension UIStoryboard {
    class func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()) }
    
    class func leftViewController() -> LeftPanel? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("LeftPanel") as? LeftPanel
    }
    
    class func centerViewController() -> MainViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("MainViewController") as? MainViewController
    }
    
}
