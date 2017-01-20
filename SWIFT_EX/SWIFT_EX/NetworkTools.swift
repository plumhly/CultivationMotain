//
//  NetworkTools.swift
//  SWIFT_EX
//
//  Created by libo on 2016/12/25.
//  Copyright © 2016年 libo. All rights reserved.
//

import UIKit
import Alamofire

//定义枚举

enum RequestType {
    case GET
    case POST
}

class NetworkTools: NSObject {
        static let shareInstance: NetworkTools = {
        let tools = NetworkTools()
        return tools
    }()
}

// MARK:- 封装请求方法
extension NetworkTools {
    func requestData(methodType: RequestType, urlString: String, parameters: [String: AnyObject]?, finished:@escaping (_ result: AnyObject?, _ error: NSError?)->()) {
        //自定义请求回调闭包
        let resultCallBack = { (response: DataResponse<Any>) in
            if response.result.isSuccess {
                finished((response.result.value as AnyObject), nil)
            } else {
                finished(nil, response.result.error as? NSError)
            }
                
        }
        
        //2.请求
        let httpMethod: HTTPMethod = methodType == .GET ? .get : .post
        request(urlString, method: httpMethod, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: resultCallBack)
    }
}
