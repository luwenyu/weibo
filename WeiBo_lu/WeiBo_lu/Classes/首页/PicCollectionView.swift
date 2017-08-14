//
//  PicCollectionView.swift
//  WeiBo_lu
//
//  Created by lu on 2017/7/6.
//  Copyright © 2017年 lu. All rights reserved.
//

import UIKit
//距离边缘15
private let edgeMargin : CGFloat = 15.0

//图片间隙

private let imageMargin : CGFloat = 10.0
class PicCollectionView: UICollectionView {

    var picURLs : [URL] = [URL](){
        
        didSet{
            reloadData()
        
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dataSource = self as UICollectionViewDataSource
        delegate = self as UICollectionViewDelegate
        self .register(UINib.init(nibName: "PicCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PicCollectionViewCell")
//       let layout = self.collectionViewLayout as! UICollectionViewFlowLayout
//        
//        //计算imageviewg宽度高度
//        let imageviewWH = (UIScreen.main.bounds.width-2*imageMargin-2*edgeMargin)/3
//        layout.itemSize = CGSize.init(width: imageviewWH, height: imageviewWH)
        
    
     
    }
    

}
extension PicCollectionView : UICollectionViewDataSource,UICollectionViewDelegate{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picURLs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let  cell : PicCollectionViewCell = collectionView .dequeueReusableCell(withReuseIdentifier: "PicCollectionViewCell", for: indexPath) as! PicCollectionViewCell
        cell.url = picURLs[indexPath.item]
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let userInfo  : [String : Any] = ["indexPath":indexPath,"picURLs":picURLs]
        
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: showPhoneBrowserNote), object: self, userInfo: userInfo)
        
        
    }

}

extension PicCollectionView : AnimaltorPresentDelegate{

    func startRect(indepath: NSIndexPath) -> CGRect {
        let  cell : PicCollectionViewCell = self.cellForItem(at: indepath as IndexPath)! as! PicCollectionViewCell
         print(cell.frame)
        let startFrame = self.convert(cell.frame, to: UIApplication.shared.keyWindow)
        print(startFrame)
        return startFrame
        
        
    }
    func endRect(indepath: NSIndexPath) -> CGRect {
        
        let pickURL = picURLs[indepath.item]
        let image = SDWebImageManager.shared().imageCache.imageFromDiskCache(forKey: pickURL.absoluteString)
        //计算结束后的位置
        let w = UIScreen.main.bounds.width
        let h  = w/(image?.size.width)! * (image?.size.height)!
        var y : CGFloat = 0
        
        if y > UIScreen.main.bounds.height {
         
           y = 0
        }
        else{
        
           y = (UIScreen.main.bounds.height-h)*0.5
        }
        
        return CGRect(x: 0, y: y, width: w, height: h)
        
        
        
        
    }
    func imageView(indepath: NSIndexPath) -> UIImageView {
        
        let imageView = UIImageView()
        let pickURL = picURLs[indepath.item]
        let image = SDWebImageManager.shared().imageCache.imageFromDiskCache(forKey: pickURL.absoluteString)
        
        imageView.image = image;
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }

}


