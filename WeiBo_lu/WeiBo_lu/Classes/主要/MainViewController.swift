//
//  MainViewController.swift
//  WeiBo
//
//  Created by lu on 17/6/8.
//  Copyright © 2017年 lu. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

     lazy var imgaeName = ["tabbar_home_selected","tabbar_message_center_selected","","tabbar_discover_selected","tabbar_profile_selected"]
     lazy var  composeBtn = UIButton(imageName: "tabbar_compose_icon_add", bgImageName: "tabbar_compose_button")
    
    override func viewDidLoad() {
        super.viewDidLoad()
       tabBar.tintColor = UIColor.orange
        addBtn()
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         setbar()
    }



}
extension MainViewController{

    func addBtn()
   {
        
          tabBar .addSubview(composeBtn)
           composeBtn.center = CGPoint(x: tabBar.center.x, y: tabBar.frame.size.height*0.5)
          composeBtn .addTarget(self, action:#selector(btnClick), for: .touchUpInside)
    


    }
     func setbar()
    {
    
    for i in 0..<tabBar.items!.count {
    let item = tabBar.items![i]
    
    if i==2 {
    item.isEnabled = false
    continue
    }
    item.selectedImage = UIImage(named:imgaeName[i])
    
    }
    
    }
    

}

extension MainViewController
{

  func btnClick() {
        
    let compostVc = ComposeViewController()
    let  nav = UINavigationController(rootViewController: compostVc)
    self.present(nav, animated: true, completion: nil)
    
    
    }

}
