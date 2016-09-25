//
//  UIViewExtension.swift
//  ZhiHuDaily
//
//  Created by 征里 on 16/9/25.
//  Copyright © 2016年 征里. All rights reserved.
//

import Foundation
import UIKit

extension UIView {

    func zl_setX( _ x : CGFloat){
        self.frame = CGRect.init(x: x, y: self.frame.origin.y, width: self.frame.size.width ,height: self.frame.size.height)
    }
    func zl_setY(_ y : CGFloat){
        self.frame = CGRect.init(x: self.frame.origin.x, y:y , width: self.frame.size.width ,height: self.frame.size.height)
    }
    func zl_setWidth(_ width : CGFloat){
        self.frame = CGRect.init(x: self.frame.origin.x, y:self.frame.origin.y , width: width ,height: self.frame.size.height)
    }
    func zl_setHeight(_ height : CGFloat){
        self.frame = CGRect.init(x: self.frame.origin.x, y:self.frame.origin.y , width: self.frame.size.width ,height:height)
    }
    func zl_setSize(_ size : CGSize){
        self.frame = CGRect.init(origin: self.frame.origin, size: size)
    }
    func zl_setOrigin(_ point : CGPoint){
        self.frame = CGRect.init(origin: point, size: self.frame.size)
    }
    
    
    func zl_x() -> CGFloat {
        return self.frame.origin.x
    }
    func zl_y() -> CGFloat {
        return self.frame.origin.x
    }
    func zl_size() -> CGSize {
        return self.frame.size
    }
    func zl_origin() -> CGPoint {
        return self.frame.origin
    }
    func zl_height() -> CGFloat {
        return self.frame.size.height
    }
    func zl_width() -> CGFloat {
        return self.frame.size.width
    }


}
