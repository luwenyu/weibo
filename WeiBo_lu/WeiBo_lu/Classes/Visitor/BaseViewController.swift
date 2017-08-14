//
//  VisitorViewController.swift
//  WeiBo
//
//  Created by lu on 17/6/8.
//  Copyright © 2017年 lu. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var isLogin : Bool = UserAccountTool.shareIntance.islogin
    lazy var viView : VisitoView  = Bundle.main.loadNibNamed("VisitoView", owner: self, options: nil)?.first as! VisitoView

    override func loadView() {
        
        isLogin ? super.loadView() : setVisitorView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNav()
        
        
        
        
    }

}

extension BaseViewController{

    //访客
    func setVisitorView() {
        view = viView
        viView.registerBtn .addTarget(self, action: #selector(BaseViewController.register), for: .touchUpInside)
        viView.loginBtn.addTarget(self, action: #selector(BaseViewController.login), for: .touchUpInside)
    }
    
    //导航栏左右item
    func setNav() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action:#selector(BaseViewController.rclick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登陆", style: .plain, target: self, action:#selector(BaseViewController.lclick))

        
    }
    
    

}

extension BaseViewController
{


    func rclick() {
        
        
        print("注册")
    }
    func lclick(){
        let oVc = OAuthViewController()
        let nav = UINavigationController(rootViewController: oVc)
        present(nav, animated: true, completion: nil)
        

        print("登陆")
    }
    func register() {
        print("注册")
    }
    func login() {
        print("登陆")
    }
}
