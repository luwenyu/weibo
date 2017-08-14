//
//  NetworkTools.swift
//  WeiBo_lu
//
//  Created by lu on 17/6/23.
//  Copyright © 2017年 lu. All rights reserved.
//

import UIKit


enum RequestType : Int{

    case GET = 0
    case POST = 1

}

class NetworkTools: AFHTTPSessionManager {

    //单例子
    static let shareInstance : NetworkTools = {
    
        let tools = NetworkTools()
        tools.responseSerializer.acceptableContentTypes?.insert("text/html")
        tools.responseSerializer.acceptableContentTypes?.insert("text/plain")

        
        return tools
    }()
    
    
}

//MARK:---封装AFNet
extension NetworkTools
{
    
    
    func requst( RequestType : RequestType, URLString: String,parameters: [String : Any],finished : @escaping (_ result : Any?,_ error : Error?)->()) {
        
        let successCallBack = { (task : URLSessionDataTask, result : Any)->Void in
            
            finished(result, nil)
            
        }
        let failureCallBack =  { (task : URLSessionDataTask?, error : Error) ->Void in
            
            finished(nil, error)
        }
        
        

        if RequestType == .GET {
            
        
        get(URLString, parameters: parameters, progress: { (progress : Progress) in
            
            
        }, success: successCallBack, failure:failureCallBack)
            
        }
            
        else{
        
        post(URLString, parameters: parameters, progress: { (prese : Progress) in
            
        }, success: successCallBack , failure : failureCallBack)
        
        }
    }
    
    
    
  
}

//MARK:-请求accessToken
extension NetworkTools{


    func loadAccessToken(code : String,finished : @escaping (_ result : [String : Any]?,_ error : Error? )->()){
        
        let urlString = "https://api.weibo.com/oauth2/access_token"
        let params = ["client_id":MJAPPKEY,
                      "client_secret":MJAPPSECRET,
                      "grant_type":"authorization_code",
                      "code":code,
                      "redirect_uri":MJREDIRECTURL]
        requst(RequestType: .POST, URLString: urlString, parameters: params) { (result, error) in
            
            finished(result as?[String : Any], error)
        }
    
    }

}

//MARK:-用户信息
extension NetworkTools{


    func loadUserInfo(access_token :String, _ uid : String,finished:@escaping (_ result : [String : Any]?,_ error : Error?)->()) {
        
        let urlString = "https://api.weibo.com/2/users/show.json"
        let parames = ["access_token" : access_token,"uid": uid]
        requst(RequestType: .GET, URLString: urlString, parameters: parames) { (result, error) in
            
            finished(result as? [String : Any], error)
            
        }
        
    }

}

//MARK:--首页数据
extension NetworkTools{

    func loadStatule(max_id : Int,since_id : Int, finished :@escaping (_ result : [[String : Any]]?, _ error : Error?)->() ){
        
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        let parame = ["access_token" :( UserAccountTool.shareIntance.accountModel?.access_token)!,"since_id":"\(since_id)","max_id":"\(max_id)"]
        requst(RequestType: .GET, URLString: urlString, parameters: parame) { (result, error) in
            
            // 转成字典
            guard let dic  = result as? [String : Any] else
            {
                finished(nil,error)
              return
            }
            //  转成数组给外界调用 [[String : Any]]  数组包字典
            finished(dic["statuses"] as? [[String : Any]],error)
            
            
        }
        
    }
    
}

//MARK:---发送微博

extension NetworkTools{
  

    func send(text : String, isSuccess:@escaping (_ isSuccess : Bool)->()){
        
       let urlStr = "https://api.weibo.com/2/statuses/update.json"
        let dic = ["access_token":( UserAccountTool.shareIntance.accountModel?.access_token)!,"status" : text]
        requst(RequestType: .POST, URLString: urlStr, parameters: dic  ) { (result, error) in
            
            if result != nil{
            
                isSuccess(true)
                
            }
            else{
                print(error!)
               isSuccess(false)
            }
            
        }
        
        
    }

}

//MARK---发送微博携带照片
extension NetworkTools{

    func sendStatus(text : String,image : UIImage,isSuccess:@escaping (Bool)->() ) {
        let urlStr = "https://api.weibo.com/2/statuses/upload.json"
        let dic = ["access_token":( UserAccountTool.shareIntance.accountModel?.access_token)!,"status" : text]

       post(urlStr, parameters: dic, constructingBodyWith: { (formData) in
        if let imageData = UIImageJPEGRepresentation(image, 0.5)
        {
           formData.appendPart(withForm: imageData, name: "pic")
        }
        
       }, progress:nil, success: { (_, _) in
        
        isSuccess(true)
       }) { (_, _) in
        
        isSuccess(false)
        }
        
    }



}


