//
//  PhotoAnimal.swift
//  WeiBo_lu
//
//  Created by lu on 2017/8/9.
//  Copyright © 2017年 lu. All rights reserved.
//

import UIKit

//面向协议开发
protocol AnimaltorPresentDelegate : NSObjectProtocol{
    
    func startRect(indepath : NSIndexPath) -> CGRect
    func endRect(indepath : NSIndexPath) -> CGRect
    func imageView(indepath : NSIndexPath) -> UIImageView
}

protocol AnimalDismissDelegate  : NSObjectProtocol{
    
    func indexpath() -> NSIndexPath
    func imageview() -> UIImageView
    
}

class PhotoAnimal: NSObject {

    var ispresent : Bool = false
    
    var presentDelegate : AnimaltorPresentDelegate?
    var indexp : NSIndexPath?
    var dismissDelegate : AnimalDismissDelegate?
    
    
    
}



extension PhotoAnimal : UIViewControllerTransitioningDelegate{

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        ispresent = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
         ispresent = false
        return self
    }
    
  
}
extension PhotoAnimal  : UIViewControllerAnimatedTransitioning{

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        
        ispresent ? present(transitionContext: transitionContext) : dismiss(transitionContext: transitionContext)
    }
    
    func present(transitionContext: UIViewControllerContextTransitioning) {
        
        guard let presentDelegate = presentDelegate,let indexp = indexp else {
            return
        }
        
        
        //取出弹出的view
        let presentView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        
        //将弹出的view添加到contenview
        transitionContext.containerView.addSubview(presentView)
        //  动画
        presentView.alpha = 0.0
        //获取执行动画的imageview
        let startFrame = presentDelegate.startRect(indepath: indexp)
        let imageView = presentDelegate.imageView(indepath: indexp)
        transitionContext.containerView.addSubview(imageView)
        imageView.frame = startFrame
        
        //transitionContext.containerView.backgroundColor = UIColor.clear
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
          imageView.frame = presentDelegate.endRect(indepath: indexp)
        }) { (_) in
            
            imageView.removeFromSuperview()
            
            //transitionContext.containerView.backgroundColor = UIColor.clear
            presentView.alpha = 1.0

            transitionContext.completeTransition(true)
        }
        

        
    }
    func dismiss(transitionContext: UIViewControllerContextTransitioning) {
        
        guard let dismissDelegate = dismissDelegate,let presentDelegate = presentDelegate else {
            return
        }
        
        let dismissView = transitionContext.view(forKey: .from)
        dismissView?.removeFromSuperview()
        
        let imageView = dismissDelegate.imageview()
        transitionContext.containerView.addSubview(imageView)
        let indexp = dismissDelegate.indexpath()
        

        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            imageView.frame = presentDelegate.startRect(indepath: indexp)
        }) { (_) in
            
            transitionContext.completeTransition(true)
        }
        
    }
    
    
    
   
    

}
