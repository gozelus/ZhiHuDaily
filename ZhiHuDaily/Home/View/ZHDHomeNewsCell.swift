//
//  ZHDHomeNewsCell.swift
//  ZhiHuDaily
//
//  Created by 征里 on 16/9/25.
//  Copyright © 2016年 征里. All rights reserved.
//

import UIKit
import SDWebImage
import SnapKit

let kTitleLabelFontSize : CGFloat = 13.0
let kImgViewSize : CGSize = CGSize(width: 30, height: 30)
let kTitleLabelOffset : CGFloat = 20.0
let kTitleLabelWidth : CGFloat = 100.0

class ZHDHomeNewsCell: UITableViewCell {

    
    private var titleLabel : UILabel = UILabel()
    private var imgView : UIImageView = UIImageView()
    

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .yellow
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    //MARK: - Private
    private func setupSubviews(){
        
        self.titleLabel.font = UIFont.systemFont(ofSize: kTitleLabelFontSize)
        self.titleLabel.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        self.addSubview(self.titleLabel)
        self.addSubview(self.imgView)
        
        self.titleLabel.snp.remakeConstraints { (make) in
            make.top.equalTo(superview!).offset(kTitleLabelOffset)
            make.left.equalTo(superview!).offset(kTitleLabelOffset)
            make.right.equalTo(self.imgView).offset(kTitleLabelOffset)
            
        }
        
        self.imgView.snp.remakeConstraints { (make) in
            make.top.right.bottom.equalTo(superview!).offset(kTitleLabelOffset)
            make.left.equalTo(self.titleLabel).offset(kTitleLabelOffset)
        }
        
    }
    
    
    
    
    //MARK: - Public
    
    /// 根据model更新cell UI
    ///
    /// - parameter model: <#model description#>
    public func updateWithModel(model : ZHDHomeNewsCellModel!){
    
        if let imgURL = model.imageURL as String!{
            
            if !imgURL.isEmpty {
                
                self.imgView.sd_setImage(with: URL(string: imgURL))
            }
        }
        
        if let title = model.title as String!{
            
            self.titleLabel.text = title
            self.titleLabel.sizeToFit()
        }
    }

    
}
