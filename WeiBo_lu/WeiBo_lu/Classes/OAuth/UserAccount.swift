//
//  Pre.swift
//  WeiBo_lu
//
//  Created by lu on 2017/6/27.
//  Copyright © 2017年 lu. All rights reserved.
//

import UIKit


class UserAccount: NSObject,NSCoding {

    var access_token : String?
    var expires_in : TimeInterval = 0.0
    {
        willSet{
            print("xxxx")

        }
        didSet{
            print("xxxx")
          expires_date = NSDate(timeIntervalSinceNow: expires_in * 60 * 60)
        }
        
       
    }
    var uid :String?
    
    //过期日期 s
    var expires_date : NSDate?
    
    //昵称
    var screen_name:String?
    
    //头像地址
    var avatar_hd : String?
    
    
    
    
    
    
    
    //自定义构造函数
    init(dic : [String :Any]){
       super.init()
      
//        access_token = dic["access_token"] as? String
//        self.expires_in = dic["expires_in"] as! TimeInterval
        //uid = dic["uid"] as? String
        
        setValuesForKeys(dic)
        
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
    override var description: String{
    
        //重写des属性
      return dictionaryWithValues(forKeys: ["access_token","expires_date","uid","screen_name","avatar_hd"]).description
    }
    
    //MARK:-- 归档 & 解档
    //解档
    required init?(coder aDecoder: NSCoder) {
        
        access_token  = aDecoder.decodeObject(forKey: "access_token") as? String
        uid  = aDecoder.decodeObject(forKey: "uid") as? String
        expires_date  = aDecoder.decodeObject(forKey: "expires_date") as? NSDate
        avatar_hd  = aDecoder.decodeObject(forKey: "avatar_hd") as? String
        screen_name  = aDecoder.decodeObject(forKey: "screen_name") as? String

    }
    //归档
    func encode(with aCoder: NSCoder) {
        aCoder.encode(access_token, forKey: "access_token")
        aCoder.encode(uid, forKey: "uid")
        aCoder.encode(expires_date, forKey: "expires_date")
        aCoder.encode(avatar_hd, forKey: "avatar_hd")
        aCoder.encode(screen_name, forKey: "screen_name")


    }
    
    
}


    
