//
//  UserAccountTool.swift
//  WeiBo_lu
//
//  Created by lu on 2017/6/29.
//  Copyright © 2017年 lu. All rights reserved.
//

import UIKit

class UserAccountTool {

    static let shareIntance : UserAccountTool = UserAccountTool()
    
    var accountModel : UserAccount?
    
    //MARK:-****计算属性
    var path : String{
        //取沙河中的归档
        var path = NSSearchPathForDirectoriesInDomains(.cachesDirectory,.userDomainMask, true).last!
        path = path + "/account.plist"
        return path
        
    }
    
    //MARK:-****重写init
    init() {
     //解档
       accountModel =  NSKeyedUnarchiver.unarchiveObject(withFile: path) as?UserAccount
    }
    
    var islogin : Bool {
    
        if accountModel==nil {
            return false
        }
        guard let expires_date = accountModel?.expires_date else {
            return false
        }
        return expires_date.compare(Date()) == ComparisonResult.orderedDescending
    
    }
    
    
  
}
