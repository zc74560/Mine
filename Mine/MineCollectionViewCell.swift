//
//  MineCollectionViewCell.swift
//  Mine
//
//  Created by 赵安 on 2017/9/25.
//  Copyright © 2017年 zc. All rights reserved.
//

import UIKit

class MineCollectionViewCell: UICollectionViewCell {
    var label = UILabel()
    var imageView : UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //label = UILabel.init(frame: self.bounds)
        //self.addSubview(label)
        
    }
    
    func loadPic(cellNum : Int) {
        var imageName : String?
        switch cellNum {
        case 1:
            imageName = "1.png"
        case 2:
            imageName = "2.png"
        case 3:
            imageName = "3.png"
        case 4:
            imageName = "4.png"
        case 5:
            imageName = "5.png"
        case 6:
            imageName = "6.png"
        case 7:
            imageName = "7.png"
        case 8:
            imageName = "8.png"
        case -1:
            imageName = "Block.png"
        case 0:
            imageName = "Blank.png"
        case 9:
            imageName = "Mine.png"
            
        default:
            imageName = "Blank.png"
        }
        
        imageView = UIImageView(image:UIImage(named:imageName!))
        self.addSubview(imageView!)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
