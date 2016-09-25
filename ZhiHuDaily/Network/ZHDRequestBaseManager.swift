//
//  ZHDRequestBaseManager.swift
//  ZhiHuDaily
//
//  Created by 征里 on 16/9/25.
//  Copyright © 2016年 征里. All rights reserved.
//

import UIKit

let currentQueue = DispatchQueue.global()


class ZHDRequestManagerBase{
    
    class func request(
                        _ URLString : String!,
                        _ paras : [String : String]!,
                        _ success : (_ data : AnyObject?) -> Void ,
                        _ failure : (_ error : NSError?) -> Void){
        
        
        
        var sumpa = URLString +  "?"
        for key in paras.keys{
            let valueS = paras[key]!
            let pa = key + "&" + valueS
            sumpa += pa
        }
        let url : URL = URL.init(string: sumpa)!
        let session =  URLSession.init()
        var urlRequest = URLRequest.init(url: url)

        currentQueue.async {
        

            
        }
        
    }

}


