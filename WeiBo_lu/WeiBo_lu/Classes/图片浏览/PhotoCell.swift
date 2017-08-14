//
//  PhotoCell.swift
//  WeiBo_lu
//
//  Created by lu on 2017/8/9.
//  Copyright © 2017年 lu. All rights reserved.
//

import UIKit

protocol photDelegate : NSObjectProtocol {
    
    func imageViewClick()
}

class PhotoCell: UICollectionViewCell {
    
    var pikURL : URL?{
      
        didSet{
        
            setConten(picURL: pikURL)
           }
    
    }
    var delegate : photDelegate?
    
    fileprivate lazy var progress : ProgressView = ProgressView()
    lazy  var imageView : UIImageView = UIImageView()
    fileprivate lazy var scrolView : UIScrollView = UIScrollView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension PhotoCell{


    fileprivate func setUI(){
    
        contentView.addSubview(scrolView)
        scrolView.addSubview(imageView)
         contentView.addSubview(progress)
        scrolView.frame = contentView.bounds
        scrolView.frame.size.width -= 20
        progress.bounds = CGRect(x: 0, y: 0, width: 50, height: 50)
        progress.center = CGPoint(x: UIScreen.main.bounds.width*0.5, y: UIScreen.main.bounds.height*0.5)
        progress.isHidden = true
        
        let  tap = UITapGestureRecognizer(target: self, action: #selector(dismiss))
        imageView.addGestureRecognizer(tap)
        imageView.isUserInteractionEnabled = true
        
    }
}

//MARK:---事件监听
extension PhotoCell{

    @objc fileprivate func dismiss(){
    
        
        delegate?.imageViewClick()
    
    }
    
}
extension PhotoCell{

    fileprivate func setConten(picURL : URL?){
    
        guard let picURL = picURL else {
            
            return
        }
        let  image = SDWebImageManager.shared().imageCache.imageFromDiskCache(forKey: picURL.absoluteString)
        
        let witdth = UIScreen.main.bounds.width
        let height = witdth/(image?.size.width)! * (image?.size.height)!
        
        
        var y : CGFloat = 0
        if height > UIScreen.main.bounds.height{
            y = 0
        }
        else{
            
            y = (UIScreen.main.bounds.height - height)*0.5
        }
        
        imageView.frame = CGRect(x: 0, y: y, width: witdth, height: height)
        progress.isHidden = false
        imageView.sd_setImage(with: getBigURL(smallURL: picURL), placeholderImage: image, options: [], progress: { (cureent, total) in
            
            print("进度")
            self.progress.progress = CGFloat(cureent)/CGFloat(total)
            
        }) { (_, _, _, _) in
            
            self.progress.isHidden = true
        }
        
        
        scrolView.contentSize = CGSize(width: 0, height: height)
        
        
    }
    
    fileprivate func getBigURL(smallURL : URL) -> URL{
    
        let samllURLString = smallURL.absoluteString
        let bigURLString = samllURLString.replacingOccurrences(of: "thumbnail", with: "bmiddle")
        return NSURL(string: bigURLString)! as URL
        
        
    
    
    }
    
}



