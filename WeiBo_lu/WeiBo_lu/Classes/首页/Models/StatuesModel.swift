//
//  StatuesModel.swift
//  WeiBo_lu
//
//  Created by lu on 2017/7/3.
//  Copyright © 2017年 lu. All rights reserved.
//

import UIKit

class StatuesModel: NSObject {

    var  created_at : String? //创建时间
    var source : String? //来源
    var text : String? //正文
    var mid : Int = 0 //微博id
    var userModel :UserModel? //用户信息
    var pic_urls : [[String : String]]?//配图
    var retweeted_status : StatuesModel?// 转发微博
    
    
    
    
    
    init(dic : [String : Any]){
     super .init()
        setValuesForKeys(dic)
        
        //用户
        if let userDic = dic["user"] as? [String :Any] {
            
            userModel = UserModel(dic: userDic)
        }
        
        //转发微博
        if let dic = dic["retweeted_status"] as? [String :Any] {
            
            retweeted_status = StatuesModel(dic: dic)
            
            
        }
        
    
    }
    
   
    
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }

    
}
