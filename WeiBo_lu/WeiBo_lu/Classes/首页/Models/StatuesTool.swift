//
//  StatuesTool.swift
//  WeiBo_lu
//
//  Created by lu on 2017/7/5.
//  Copyright © 2017年 lu. All rights reserved.
//

import UIKit

class StatuesTool: NSObject {

    // 对数据属性处理
    var status : StatuesModel?
    var sourceText : String?
    var creatAtText:String?
    
    var verifiedImage : UIImage?
    var vipImage : UIImage?
    var profileURL : URL?
    var picURLs : [URL] = [URL]()
    
    var cellHeight : CGFloat = 0
    
    
    
    init(statusModel : StatuesModel) {
        super.init()
        self.status = statusModel
        
        //来源处理
        if let sou = statusModel.source, sou != ""  {
           
        let startIndex = (sou as NSString).range(of: ">").location + 1
        let lenght = (sou as NSString).range(of: "</").location -  (sou as NSString).range(of: ">").location
        //截取字符串
        sourceText = (sou as NSString).substring(with: NSRange(location: startIndex, length: lenght-1))
       
        }
        
        // 处理时间
        if let creatA = statusModel.created_at{
        
          creatAtText = NSDate.creatDateStrig(createAtStr: creatA)
            
        
        }
        
        //处理认证
        let verifiedtype = statusModel.userModel?.verified_type ?? -1
        
        switch verifiedtype {
        case 0:
            verifiedImage = UIImage(named: "avatar_vip")
        case 2,3,5:
            verifiedImage = UIImage(named: "avatar_enterprise_vip")
        case 220:
            verifiedImage = UIImage(named: "avatar_grassroot")
        default:
            verifiedImage = nil
        }
        //处理会员图标
        let mbrank = statusModel.userModel?.mbrank ?? 0
        if mbrank>0 && mbrank<=6 {
            vipImage = UIImage(named: "common_icon_membership_level\(mbrank)")
            
        }
        
        //处理用户头像
        let profileString = statusModel.userModel?.profile_image_url ?? ""
        profileURL = URL(string: profileString)
        
        //处理配图
        if let picURL = status?.pic_urls!.count != 0 ? status?.pic_urls : status?.retweeted_status?.pic_urls{
            
            for picDic in picURL
            {
                
                guard let urlString = picDic["thumbnail_pic"] else
                {
                    continue
                }
                
                picURLs.append(URL(string: urlString)!)
            
            }
            
        }
        
    

    }
}
