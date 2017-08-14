//
//  WelcomViewController.swift
//  WeiBo_lu
//
//  Created by lu on 2017/6/29.
//  Copyright © 2017年 lu. All rights reserved.
//

import UIKit

class WelcomViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    //MARK:-****距离底部的约束
    @IBOutlet weak var iconBottomC: NSLayoutConstraint!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置头像
        let imageurl = UserAccountTool.shareIntance.accountModel?.avatar_hd
        //如果??前面的可选类型有值,那么将前面的可选类型解包赋值
        //如果??前面可选类型为nil,那么用??后面的值
        let url = URL(string: imageurl ?? "");
        
        iconImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "avatar_default_big"))
        
        //改变约束值
        iconBottomC.constant = UIScreen.main.bounds.height-250

        //执行动画
        //usingSpringWithDamping 阻力系数  越大效果不明显 0 -1
        // initialSpringVelocity 初始化速度
        // 枚举类型不传用[]

        
        
        UIView.animate(withDuration: 2.0,
                       delay: 0,
                       usingSpringWithDamping: 0.4,
                       initialSpringVelocity: 0,
                       options: [],
                       animations: {
                        //更新约束
                        self.view.layoutIfNeeded()
                        
        }) { (_) in
            
            UIView.animate(withDuration: 1.0, animations: {
                self.tipLabel.alpha = 1.0
            }, completion: { (_) in
                
              UIApplication.shared.keyWindow?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()!
                
                            })
        }
        
    }

  

}
