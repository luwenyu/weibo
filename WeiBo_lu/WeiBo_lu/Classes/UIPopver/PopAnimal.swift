//
//  PopAnimal.swift
//  WeiBo
//
//  Created by lu on 17/6/22.
//  Copyright © 2017年 lu. All rights reserved.
//

import UIKit

class PopAnimal: NSObject {

    var ispresent: Bool = false
    var presentFame : CGRect = CGRect.zero
    
    var block : (( Bool) ->())?
    
    init(block : @escaping (Bool)->()) {
       self.block = block
    }
    

}


//MARK:-- 转场代理
extension PopAnimal:UIViewControllerTransitioningDelegate{
    
    //改view尺寸
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        let prentVC = MyUIPresentationController(presentedViewController: presented, presenting: presenting)
        prentVC.presentFame = presentFame
        return prentVC
    }
    
    //自定义弹出动画
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        ispresent = true
        block!( ispresent)

        return self
        
    }
    //自定义消失动画
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        ispresent = false
        block!(ispresent)

        return self
    }
    
}

//MARK:---弹出和消息动画代理
extension PopAnimal : UIViewControllerAnimatedTransitioning{
    
    //动画时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    //获取转场上下文,通过转场上下文获取弹出view和消失的view
    //UITransitionContextToViewKey 获取弹出view
    //   UITransitionContextFromViewKey //获取消失view
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        ispresent ? animalpresent(transitionContext: transitionContext) : animaldismis(transitionContext: transitionContext)
        
    }
    
    //自定义弹出动画
    func animalpresent(transitionContext: UIViewControllerContextTransitioning) {
        
        //获取弹出view
        let presentView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        //将弹出的view添加到containerview中
        transitionContext.containerView.addSubview(presentView)
        
        //执行动画
        presentView.transform = CGAffineTransform.init(scaleX: 1.0, y: 0.0)
        presentView.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        UIView.animate(withDuration: 0.5, animations:{
            
        })
        UIView.animate(withDuration: 1, animations: {
            
            presentView.transform = CGAffineTransform.identity
            
        }) { (_) in
            
            transitionContext.completeTransition(true)
            
        }
        
    }
    //自定消失动画
    func animaldismis(transitionContext: UIViewControllerContextTransitioning) {
        
        
        let  dismissView = transitionContext.view(forKey: UITransitionContextViewKey.from)
        UIView.animate(withDuration: 0.5, animations: {
            
            dismissView?.transform = CGAffineTransform.init(scaleX: 1, y: 0.0001)
        }) { (_) in
            
            dismissView!.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
    }
    
}

