 

//
//  HTTPRequestBase.swift
//  ZhiHuDaily
//
//  Created by 征里 on 16/9/26.
//  Copyright © 2016年 征里. All rights reserved.
//

import UIKit
import Alamofire

 fileprivate let baseURLString = "http://news-at.zhihu.com/api/4"
 
class HTTPRequestBase{


    public class   func get(urlStr : String!,
                            params : [String : String]!,
                            success : @escaping (_ data : JSON) -> Void,
                            failure : @escaping (_ error : Error) -> Void){
        
        
        let fullURL : URL = URL.init(string: baseURLString + urlStr)!
 
        Alamofire.request(fullURL).responseJSON { (response) in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                success(json)
            case .failure(let error):
                failure(error)
            }
            
        }
 
    }
 
}

 
