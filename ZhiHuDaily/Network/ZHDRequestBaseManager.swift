//
//  ZHDRequestBaseManager.swift
//  ZhiHuDaily
//
//  Created by 征里 on 16/9/25.
//  Copyright © 2016年 征里. All rights reserved.
//

import UIKit

let currentQueue = DispatchQueue.global()
let mainQueue = DispatchQueue.main

class ZHDRequestManagerBase{
    
    class func request(
                        _ URLString : String!,
                        _ paras : [String : String]!,
                        _ success : (_ data : AnyObject?) -> Void ,
                        _ failure : (_ error : NSError?) -> Void){
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        var sumpa = URLString +  "?"
        for key in paras.keys{
            let valueS = paras[key]!
            let pa = key + "&" + valueS
            sumpa += pa
        }
        let url : URL = URL(string: sumpa)!
        let defaultConfiguration = URLSessionConfiguration.default
        let sessionWithoutADelegate = URLSession(configuration: defaultConfiguration)

        currentQueue.async {
            (sessionWithoutADelegate.dataTask(with: url, completionHandler: { (data, response, error) in
                
                mainQueue.async {
                    if let response = response{
                        
                        print(NSString(data: data!, encoding:String.Encoding.utf8.rawValue))
                        
                        print(data,response)
                    }else if let error = error{
                        print(error)
                    }

                }
            })).resume()

            
        }
        
    }

}


