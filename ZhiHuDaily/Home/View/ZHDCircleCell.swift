
//
//  ZHDCircleCell.swift
//  ZhiHuDaily
//
//  Created by 征里 on 16/9/28.
//  Copyright © 2016年 征里. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

fileprivate let kTitileLabelFontSize  = 18.0
fileprivate let kTitleLabelPadding = 13.0

class ZHDCircleCell: UIImageView {

    private var imgUrl: URL?
    private var title: String?
    private var titleLabel = UILabel()
    
    
    //MARK: - Public
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(_ imgUrl : URL, _ title : String){
        self.init(frame:CGRect.zero)
        
        self.contentMode = .scaleAspectFill
        
        self.imgUrl = imgUrl
        self.title = title
        
        setupSubview()
    }
    
    
    // MARK:- Private
    private func setupSubview(){
        if let url = self.imgUrl {
            self.sd_setImage(with: url)
        }
        
        let coverView = UIView()
        coverView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        coverView.alpha = 0.2
        self.addSubview(coverView)
        coverView.snp.makeConstraints { (make) in
            make.size.equalTo(self.snp.size)
            make.center.equalTo(self.snp.center)
        }
        
        self.titleLabel.font = UIFont.systemFont(ofSize: CGFloat(kTitileLabelFontSize))
        self.titleLabel.numberOfLines = 0
        self.titleLabel.text = self.title
        self.titleLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.addSubview(self.titleLabel)
        
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(kTitleLabelPadding)
            make.right.equalTo(self.snp.right).offset(-kTitleLabelPadding)
            make.bottom.equalTo(self.snp.bottom).offset(-1.5 * kTitleLabelPadding)
        }
    }

}
