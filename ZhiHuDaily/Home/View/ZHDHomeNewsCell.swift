//
//  ZHDHomeNewsCell.swift
//  ZhiHuDaily
//
//  Created by 征里 on 16/9/25.
//  Copyright © kPadding16年 征里. All rights reserved.
//

import UIKit
import SDWebImage
import SnapKit

let kTitleLabelFontSize : CGFloat = 13.0
let kImgViewSize : CGSize = CGSize(width: 30, height: 30)
let kPadding : CGFloat  =  20

class ZHDHomeNewsCell: UITableViewCell {

    
    private var titleLabel = UILabel()
    private var imgView = UIImageView()
    private var constraint : Constraint?

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        // Setup UI
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    // MARK: - Private
    private func setupSubviews() {
        
        self.titleLabel.font = UIFont.systemFont(ofSize: kTitleLabelFontSize)
        self.titleLabel.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        self.titleLabel.numberOfLines = 0
        self.addSubview(self.titleLabel)
        self.addSubview(self.imgView)
                
        //MARK : - 子view布局
        self.titleLabel.snp.remakeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(kPadding)
            make.left.equalTo(self.snp.left).offset(kPadding)
            make.right.equalTo(self.snp.right).offset(-100)
            self.constraint =  make.height.equalTo(0).constraint
        }
        
        self.imgView.snp.makeConstraints { (make) in
            make.left.equalTo(self.titleLabel.snp.right).offset(kPadding)
            make.right.equalTo(self.snp.right).offset(-kPadding)
            make.bottom.equalTo(self.snp.bottom).offset(-kPadding)
            make.top.equalTo(self.snp.top).offset(kPadding)
        }
    }
    
    
    
    
    // MARK: - Public
    
    // 根据model更新cell UI
    public func updateWithModel(model: ZHDHomeNewsCellModel){
    
        if let imgURL = model.imageURL, imgURL.isEmpty == false {
            self.imgView.sd_setImage(with: URL(string: imgURL))
        }
        
        if let title = model.title {
            self.titleLabel.text = title
            let label  = UILabel()
            label.text = title
            label.font = UIFont.systemFont(ofSize: kPadding)
            label.numberOfLines = 5
            label.frame.size = CGSize(width: ZHDScreenWidth - kPadding - 100, height: CGFloat(MAXFLOAT))
            label.sizeToFit()
            self.constraint?.update(offset: label.zl_height())
        }
    }

    
}
