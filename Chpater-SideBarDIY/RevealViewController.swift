//
//  RevealViewController.swift
//  Chpater-SideBarDIY
//
//  Created by JSMAC on 2020/02/16.
//  Copyright © 2020 JSPRO. All rights reserved.
//

import UIKit

class RevealViewController: UIViewController {
    var contentVC: UIViewController?
    var sideVC: UIViewController?
    var isSideBarShowing = false
    
    let SLIDE_TIME = 0.3
    let SLIDE_WIDTH: CGFloat = 260
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    // 초기 화면을 설정한다.
    func setupView() {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "sw_front") as? UINavigationController {
            self.contentVC = vc
            self.addChild(vc)
            self.view.addSubview(vc.view)
            vc.didMove(toParent: self)
            
            let frontVC = vc.viewControllers[0] as? FrontViewController
            frontVC?.delegate = self
        }
    }
    
    // 사이드 바의 뷰를 읽어온다.
    func getSideView() {
        if self.sideVC == nil {
            if let vc = self.storyboard?.instantiateViewController(identifier: "sw_rear") {
                self.sideVC = vc
                self.addChild(vc)
                self.view.addSubview(vc.view)
                vc.didMove(toParent: self)
                self.view.bringSubviewToFront((self.contentVC?.view)!)
            }
        }
    }
    
    // 콘텐츠 뷰에 그림자 효괄를 준다.
    func setShadowEffect(shadow: Bool, offset: CGFloat) {
        if (shadow == true) {
            self.contentVC?.view.layer.cornerRadius = 10
            self.contentVC?.view.layer.shadowOpacity = 0.8
            self.contentVC?.view.layer.shadowColor = UIColor.black.cgColor
            self.contentVC?.view.layer.shadowOffset = CGSize(width: offset, height: offset)
        } else {
            self.contentVC?.view.layer.cornerRadius = 0.0
            self.contentVC?.view.layer.shadowOffset = CGSize(width: 0, height: 0)
        }
    }
    
    // 사이드바를 연다
    func openSideBar(_ complete: ( () -> Void)? ) {
        self.getSideView()
        self.setShadowEffect(shadow: true, offset: -2)
//        let options = UIViewAnima
        let option = UIView.AnimationOptions([.curveEaseInOut, .beginFromCurrentState])
        UIView.animate(
            withDuration: TimeInterval(self.SLIDE_TIME),
            delay: TimeInterval(0),
            options: option,
            animations: {
             self.contentVC?.view.frame =
                 CGRect(x: self.SLIDE_WIDTH, y: 0,
                        width: self.view.frame.width,
                        height: self.view.frame.height)
            },
            completion: {
                if $0 == true {
                    self.isSideBarShowing = true
                    complete?()
            }
           }
        )
    }
    
    //사이드바를 닫는다.
    func closeSideBar(_ complete: ( () -> Void)? ) {
        let options = UIView.AnimationOptions([.curveEaseInOut, .beginFromCurrentState])
        
        UIView.animate(
            withDuration: TimeInterval(self.SLIDE_TIME),
            delay: TimeInterval(0),
            options: options,
            animations: {
                self.contentVC?.view.frame = CGRect(x:0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            },
            completion: {
                if $0 == true {
                    self.sideVC?.view.removeFromSuperview()
                    self.sideVC = nil
                    self.isSideBarShowing = false
                    self.setShadowEffect(shadow: false, offset: 0)
                    complete?()
                }
        })
    }
}
