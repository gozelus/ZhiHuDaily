


//
//  ZHDHomeBannerCell.swift
//  ZhiHuDaily
//
//  Created by 征里 on 16/9/25.
//  Copyright © 2016年 征里. All rights reserved.
//

import UIKit
import SnapKit

class ZHDHomeBannerCell: UITableViewCell {
    
    
    private var circleView : ZHDCircle = ZHDCircle()
    private var circleViewTop: Constraint?
    
    

    private var DepthFieldView : UIImageView?
    
    private var depthFieldlTopConstraint : Constraint?
    private var depthFieldBottomConstranit : Constraint?
    
    private var depthFieldSize : Constraint?
    public var BannerModels : [ZHDHomeTopBannerModel]?
    
    
    

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.initSubviews()
    }
    
    func initSubviews(){
        
        self.addSubview(self.circleView)
        self.circleView.snp.makeConstraints { (make) in
            
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            self.circleViewTop = make.top.equalTo(self.snp.top).offset(-64).constraint
            make.bottom.equalTo(self.snp.bottom)
        }
    }
   
    public func updateWithBannerModel(_ models : [ZHDHomeTopBannerModel]!){
        
        self.BannerModels = models
        
        var urls : [String] = [String]()
        for  model in self.BannerModels!{
            
            if let urlStrng : String = model.imgeURL!{
                urls.append(urlStrng)
            }
        }
        
        self.circleView.update(urls)
    }
    
    
    public func updateDepthFieldView(_ scale : CGFloat){
        if scale < 0 {
            return
        }
        self.circleViewTop?.update(offset: -64 - 100 * scale )
    }
    
    
    
    
    
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        //        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
}
