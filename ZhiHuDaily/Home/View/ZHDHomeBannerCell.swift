


//
//  ZHDHomeBannerCell.swift
//  ZhiHuDaily
//
//  Created by 征里 on 16/9/25.
//  Copyright © 2016年 征里. All rights reserved.
//

import UIKit

class ZHDHomeBannerCell: UITableViewCell {


    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .blue
        
        
        self.initSubviews()
    }
    
    func initSubviews(){
        let view =  UIView()
        view.zl_setY(-64)
        view.zl_setSize(CGSize.init(width: ZHDScreenWidth, height: 164))

        view.backgroundColor = .red
        self.addSubview(view)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
