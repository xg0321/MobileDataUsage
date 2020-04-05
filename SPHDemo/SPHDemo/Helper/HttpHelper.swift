//
//  HttpHelper.swift
//  SPHDemo
//
//  Created by admin on 2020/4/4.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import Alamofire

class HttpHelper {
    
    static let shared = HttpHelper()
    
    fileprivate var alamofireManager: SessionManager!
    
    fileprivate init() {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        alamofireManager = SessionManager(configuration: config)
    }
    
    func get(_ urlString: String, parameters: [String : Any]? = nil, completion: @escaping (String, JSON?) -> Void) {
        _ = alamofireManager.request(urlString, method: HTTPMethod.get, parameters: parameters).responseJSON { (response) in
            if let value = response.result.value {
                let json = JSON(value)
                completion("网络请求成功", json)
            } else {
                completion("网络请求失败", nil)
            }
        }
    }
    
}
