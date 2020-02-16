//
//  FrontViewController.swift
//  Chpater-SideBarDIY
//
//  Created by JSMAC on 2020/02/16.
//  Copyright © 2020 JSPRO. All rights reserved.
//

import UIKit

class FrontViewController: UIViewController {
    var delegate: RevealViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let btnSideBar = UIBarButtonItem(
            image: UIImage(named: "sidemenu"),
            style: .plain,
            target: self,
            action: #selector(moveSide(_:)))
        self.navigationItem.leftBarButtonItem = btnSideBar
        
        let dragLeft = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(moveSide(_:)))
        dragLeft.edges = UIRectEdge.left
        self.view.addGestureRecognizer(dragLeft)
        
        let dragRight = UISwipeGestureRecognizer(target: self, action: #selector(moveSide(_:)))
        dragRight.direction = .left
        self.view.addGestureRecognizer(dragRight)
        
    }
    
    @objc func moveSide(_ sender: Any) {
        if sender is UIScreenEdgePanGestureRecognizer {
            self.delegate?.openSideBar(nil)
        } else if sender is UISwipeGestureRecognizer {
            self.delegate?.closeSideBar(nil)
        } else if sender is UIBarButtonItem {
            if self.delegate?.isSideBarShowing == false {
                self.delegate?.openSideBar(nil)
            } else {
                self.delegate?.closeSideBar(nil)
            }
        }
    }
}
