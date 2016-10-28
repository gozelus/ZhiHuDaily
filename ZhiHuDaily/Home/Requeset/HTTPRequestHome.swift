//
//  HTTPRequestHome.swift
//  ZhiHuDaily
//
//  Created by 征里 on 16/9/26.
//  Copyright © 2016年 征里. All rights reserved.
//

import UIKit
import SwiftyJSON
fileprivate let homeURLString = "/news/latest"

class HTTPRequestHome: HTTPRequestBase {

    public class func request(
        success : @escaping (_ response : JSON) -> Void,
        failure : @escaping (_ error : Error) -> Void)
    {
        super.get(urlStr: homeURLString, params: nil, success: { (json) in
            
            success(json)
            }) { (error) in
                failure(error)
        }
    }
}
