//
//  HomeCell.swift
//  WeiBo_lu
//
//  Created by lu on 2017/7/3.
//  Copyright © 2017年 lu. All rights reserved.
//

import UIKit

//距离边缘15
private let edgeMargin : CGFloat = 15.0

//图片间隙

private let imageMargin : CGFloat = 10.0

class HomeCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: PicCollectionView!
    @IBOutlet weak var pikW: NSLayoutConstraint!
   
    @IBOutlet weak var buttomView: UIView!
    @IBOutlet weak var rewwetTop: NSLayoutConstraint!
    @IBOutlet weak var collectionBm: NSLayoutConstraint!
    @IBOutlet weak var retwwtBgView: UIView!
    @IBOutlet weak var reweetLab: UILabel!
    @IBOutlet weak var pikH: NSLayoutConstraint!
    
    //约束属性
    @IBOutlet weak var contenW: NSLayoutConstraint!
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLab: UILabel!
    
    @IBOutlet weak var rezhengImageView: UIImageView!
    
    @IBOutlet weak var timeLab: UILabel!
    @IBOutlet weak var vipImageView: UIImageView!
    @IBOutlet weak var contenLab: UILabel!
    
    @IBOutlet weak var soureLab: UILabel!
    
    var model : StatuesTool?{
    
        didSet{
        
            guard let model = model else {
                
                return
            }
            
            iconImageView.sd_setImage(with: model.profileURL, placeholderImage: UIImage(named: "avatar_default_big"))
            rezhengImageView.image = model.verifiedImage
            nameLab.text = model.status?.userModel?.screen_name
            vipImageView.image = model.vipImage
            timeLab.text = model.creatAtText
            contenLab.attributedText = FindEmotion.shanreInstance.findAttrString(text: model.status?.text, font: contenLab.font)
            
            // 计算collectonview宽度高度
            pikW.constant = jisuan(count: model.picURLs.count).width
            pikH.constant = jisuan(count: model.picURLs.count).height
            collectionView.picURLs = model.picURLs
            
            //转发微博
            if model.status?.retweeted_status != nil
            {
              if let screeName = model.status?.retweeted_status?.userModel?.screen_name,let retweetxt = model.status?.retweeted_status?.text
                {
                   
                    let reweet = "@" + "\(screeName):" + "\(retweetxt)"
                    reweetLab.attributedText = FindEmotion.shanreInstance.findAttrString(text: reweet, font: reweetLab.font)

                    //显示转发微博背景
                    retwwtBgView.isHidden = false
                    rewwetTop.constant = 15

                }
            
            }
                
            else{
                reweetLab.text = nil
                //隐藏转发微博背景
                retwwtBgView.isHidden = true
                rewwetTop.constant = 0

            }
            
            //计算cell高度
            //强制布局
            layoutIfNeeded()
            //获取底部view最大y值
            model.cellHeight = buttomView.frame.maxY
            
            
        }
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        //正文宽度
        contenW.constant = UIScreen.main.bounds.size.width-edgeMargin * 2
        
    }

    
    
}

//MARK:---计算collectonview宽度高度

extension HomeCell{


    func jisuan(count : Int) ->CGSize {
       
        //没有配图
        if  count==0 {
            collectionBm.constant = 0
            return CGSize.zero
        }
        //距离底部约束
        collectionBm.constant = 10

        //取layout
        let layout = collectionView.collectionViewLayout  as! UICollectionViewFlowLayout
        
        
        
        //单张
        if count == 1 {
            
            //取图片
            let image = SDWebImageManager.shared().imageCache.imageFromDiskCache(forKey: model?.picURLs.last?.absoluteString)
            layout.itemSize = CGSize.init(width: (image?.size.width)!, height: (image?.size.height)!)

            
            return CGSize.init(width: (image?.size.width)!, height: (image?.size.height)!)
            
            
        }
        
        
        //计算imageviewg宽度高度
        let imageviewWH = (UIScreen.main.bounds.width-2*imageMargin-2*edgeMargin)/3
        layout.itemSize = CGSize.init(width: imageviewWH, height: imageviewWH)
        
        
        //4张配图
        if count == 4 {
            
            let  picWH = imageviewWH * 2 + imageMargin + 1
            return CGSize(width: picWH, height: picWH)
            
            
        }
        //其他配图
        //行数
        let row = CGFloat((count-1)/3+1)
        //计算高
        let picViewH = row*imageviewWH + (row - 1) * imageMargin
        //计算宽
        let picW = UIScreen.main.bounds.width-2*edgeMargin
        return CGSize(width: picW, height: picViewH)
        
      
        
        
    }

}




