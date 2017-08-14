//
//  PickView.swift
//  WeiBo_lu
//
//  Created by lu on 2017/7/11.
//  Copyright © 2017年 lu. All rights reserved.
//

import UIKit

fileprivate let pCell = "pickcell"
class PickView: UICollectionView {

    var images : [UIImage] = [UIImage]()

    override func awakeFromNib() {
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let itemH = (UIScreen.main.bounds.width - 4*10)/3
        layout.itemSize = CGSize(width: itemH, height: itemH)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        contentInset = UIEdgeInsetsMake(10, 10, 0, 10)
        
        register(UINib.init(nibName: "PickCell", bundle: nil), forCellWithReuseIdentifier: pCell)
       // register(PickCollectionViewCell.self, forCellWithReuseIdentifier: "hehe")
        dataSource = self

        
        
    }

}
extension PickView : UICollectionViewDataSource{

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return  images.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : PickCell = collectionView.dequeueReusableCell(withReuseIdentifier: pCell, for: indexPath) as! PickCell
        cell.backgroundColor = UIColor.white

        cell.image = indexPath.item <= images.count-1 ?  images[indexPath.item] : nil
        return cell 
        
        
    }
    
    
}
