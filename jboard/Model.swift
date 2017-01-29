//
//  model.swift
//  jboard
//
//  Created by Luis Ezcurdia on 11/21/16.
//  Copyright © 2016 Luis Ezcurdia. All rights reserved.
//

import Foundation
import Alamofire

typealias jsonObject = [String : AnyObject]
typealias jsonHandler = (jsonObject) -> Void
typealias errorHandler = (Error?) -> Void

class Model {
    var rules: [String:[Validation.rule]] = [:]
    init() {}

    static func make(_ request: URLRequestConvertible, onSuccess success: jsonHandler?) {
        self.make(request, onSuccess: success, onFail: nil)
    }

    static func make(_ request: URLRequestConvertible, onSuccess success: jsonHandler?, onFail fail: errorHandler?) {
        Alamofire.request(request).responseJSON { response in
            if response.result.isSuccess,
                let data = response.result.value as? [String : AnyObject] {
                success?(data)
            } else {
                let error = response.result.error ?? CustomErrors.api(json: response.result.value as? [String:AnyObject])
                fail?(error)
            }
        }
    }

    func make(_ request: URLRequestConvertible, onSuccess success: jsonHandler?) {
        self.make(request, onSuccess: success, onFail: nil)
    }

    func make(_ request: URLRequestConvertible, onSuccess success: jsonHandler?, onFail fail: errorHandler?) {
        Model.make(request, onSuccess: success, onFail: fail)
    }
}

extension Model : JSONAble {}
extension Model : Validable {
    func isValid() -> Bool {
        return self.errors.isEmpty
    }
}
