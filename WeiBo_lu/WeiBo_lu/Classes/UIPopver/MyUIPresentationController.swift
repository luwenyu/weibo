//
//  MyUIPresentationController.swift
//  WeiBo
//
//  Created by lu on 17/6/21.
//  Copyright © 2017年 lu. All rights reserved.
//

import UIKit

class MyUIPresentationController: UIPresentationController {
    
    var presentFame : CGRect = CGRect.zero
    
    fileprivate lazy var coverview:UIView = UIView()
    override func containerViewWillLayoutSubviews() {
       
        super.containerViewWillLayoutSubviews()
        
        //弹出view尺寸
        presentedView?.frame = presentFame
        //添加蒙版
       setCoverView()
    }
}
extension MyUIPresentationController
{
    fileprivate func setCoverView(){
    
        coverview.backgroundColor = UIColor(white: 0.8, alpha: 0.2)
        coverview.frame = containerView!.bounds
        containerView?.addSubview(coverview)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(MyUIPresentationController.tapclick));
        coverview.addGestureRecognizer(tap)
        
        
    }

}
extension MyUIPresentationController{

   @objc fileprivate func tapclick()
   {
    presentedViewController.dismiss(animated: true, completion: nil)
    }

}

