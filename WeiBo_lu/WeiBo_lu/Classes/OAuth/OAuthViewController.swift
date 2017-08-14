//
//  OAuthViewController.swift
//  WeiBo_lu
//
//  Created by lu on 2017/6/26.
//  Copyright © 2017年 lu. All rights reserved.
//

import UIKit


class OAuthViewController: UIViewController  {

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationBar()
         let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(MJAPPKEY)&redirect_uri=\(MJREDIRECTURL)"
       
        guard let url = URL(string: urlString) else {
            return
        }
        
        let requst  = NSURLRequest(url: url)
        webView.loadRequest(requst  as URLRequest)
        
        
    }

    

}
extension OAuthViewController
{

    func setNavigationBar() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(back))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "填充", style: .plain, target: self, action: #selector(tc))
        title = "登录页面"
    }
    
    
}
extension OAuthViewController{

    func back() {
    
        dismiss(animated: true, completion: nil)
    }
    
    func tc() {
    
        //js代码
        let jscode = "document.getElementById('userId').value = '';document.getElementById('passwd').value = '';"
        
        //执行js代码
        webView.stringByEvaluatingJavaScript(from: jscode)
        
    }


}

//MARK:---webview代理
extension OAuthViewController : UIWebViewDelegate
{
    
    func webViewDidStartLoad(_ webView: UIWebView) {
       
        
        SVProgressHUD .show()
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        SVProgressHUD.dismiss()
    }
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        
        SVProgressHUD.dismiss()
    }
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        guard let url = request.url else {
            
            return true
        }
        let urlStr = url.absoluteString
        guard urlStr.contains("code=") else {
            return true
        }
        
        //获取到code
        let code = urlStr.components(separatedBy:"code=").last!
        
        //请求获取accessToken
        loadAccessToken(code: code)
        return false
        
        
        
    }
    
    
}
extension OAuthViewController
{

     func loadAccessToken(code : String ){
    
        //拿access_token uid
    NetworkTools.shareInstance.loadAccessToken(code: code) { (dic, error) in
        
        if error != nil
        {
          print(error!)
            return
        }
        guard let accountDic = dic else{
          return
        
        }
        
        let userModel = UserAccount(dic: accountDic)
        
        
        //请求用户信息
         self.loadUserInfo(userModel: userModel)
        }
    }
    
    
    func loadUserInfo(userModel: UserAccount) {
        
        
        guard let token = userModel.access_token else {
            return
        }
        guard let uid = userModel.uid else {
            return
        }
        
        NetworkTools.shareInstance.loadUserInfo(access_token: token, uid) { (result, error) in
            
            //错误校验
            if error !=  nil{
            
                return
            }
            
            //拿用户信息
            guard let result = result else{
             
                return
            }
           
            
            userModel.screen_name = result["screen_name"] as? String
            userModel.avatar_hd = result["avatar_hd"] as? String
            print(userModel)
            
            //取沙河路径
            var path = NSSearchPathForDirectoriesInDomains(.cachesDirectory,.userDomainMask, true).last!
            path = path + "/account.plist"
            print(path)
            //归档保存对象
            NSKeyedArchiver.archiveRootObject(userModel, toFile: path)
            
            //将现在的userModel对象赋值给单例对象中
            UserAccountTool.shareIntance.accountModel = userModel
            //退出当前控制器
            self.dismiss(animated: false, completion: { 
                UIApplication.shared.keyWindow?.rootViewController = WelcomViewController()
            })
        }
        
    }

}
