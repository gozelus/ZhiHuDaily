


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
        
        

        
    }
   
    public func updateWithBannerModel(_ models : [ZHDHomeTopBannerModel]!){
        
        self.DepthFieldView = UIImageView()
        self.DepthFieldView?.contentMode = .scaleAspectFill
        self.DepthFieldView?.clipsToBounds = true
        self.addSubview(self.DepthFieldView!)
        self.DepthFieldView?.snp.makeConstraints({ (make) in
            
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            
            self.depthFieldBottomConstranit = make.bottom.equalTo(self.snp.bottom).offset(0).constraint
            self.depthFieldlTopConstraint = make.top.equalTo(self.snp.top).offset(-64).constraint
            
        })
        
        self.BannerModels = models
        
        let model = models[0] as ZHDHomeTopBannerModel
        let url = URL(string : model.imgeURL!)
        
        self.DepthFieldView?.sd_setImage(with: url)
        
    }
    
    
    public func updateDepthFieldView(_ scale : CGFloat){
    
        self.depthFieldlTopConstraint?.update(offset: -64 - 100 * scale )
    }
    
    
    
    
    
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        //        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
}
