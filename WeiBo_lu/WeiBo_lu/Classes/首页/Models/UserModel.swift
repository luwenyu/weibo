//
//  UserModel.swift
//  WeiBo_lu
//
//  Created by lu on 2017/7/5.
//  Copyright © 2017年 lu. All rights reserved.
//

import UIKit

class UserModel: NSObject {

    var screen_name: String?
    ///用户头像地址中图 （50 * 50）
    var profile_image_url: String?
    ///认证类型 -1：没有认证  0：认证用户 2，3，5：企业认证 220：达人
    var verified_type: Int = -1
    ///会员等级 0-6
    var mbrank:Int = 0
    
    // 自定义构造函数
    init(dic : [String : Any]) {
        super .init()
        setValuesForKeys(dic)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}
