//
//  User.swift
//  jboard
//
//  Created by Luis Ezcurdia on 11/5/16.
//  Copyright © 2016 Luis Ezcurdia. All rights reserved.
//

import Foundation
import Alamofire

class User : Model {
    public var id:Int = 0
    public var first_name:String = ""
    public var last_name:String = ""
    public var email:String = ""
    public var phone:String = ""
    public var image_url:String = ""
    public var gravatar_url:String = ""
    public var employer:Bool = false
    public var candidate:Bool = false
    public var facebook_uuid:String = ""
    public var facebook_token:String = ""
    
    override init() {
        super.init()
        self.rules = [
            "first_name" : [.presence],
            "last_name"  : [.presence],
            "email"      : [.presence, .formatEmail],
            "phone"      : [.presence]
        ]
    }
    
    func signUp(onSuccess success: ((String) -> Void)?, onFail fail: ((Error?) -> Void)?) {
        if !isValid() {
            fail?(nil)
            return
        }
        let request = try! APIClient.Router.register(user: self).asURLRequest()
        Alamofire.request(request).responseJSON { response in
            if response.result.isSuccess,
                let data = response.result.value as? [String:AnyObject],
                let authToken = data["auth_token"] as? String {
                success?(authToken)
            } else {
                fail?(response.result.error)
            }
        }
    }
}
