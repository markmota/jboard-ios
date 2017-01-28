//
//  Employer.swift
//  jboard
//
//  Created by Luis Ezcurdia on 11/5/16.
//  Copyright © 2016 Luis Ezcurdia. All rights reserved.
//

import Foundation
import Alamofire

class Employer: Model {
    public var id: Int = 0
    public var company_name: String = ""
    public var position: String = ""
    public var user_data: Bool = true
    public var email: String = ""
    public var phone: String = ""
    public var user: User?

    override init() {
        super.init()
        self.rules = [
            "position": [.presence],
            "company_name": [.presence]
        ]
    }

    init(withJSON json: [String : AnyObject]) {
        self.id = json["id"] as? Int ?? 0
        self.company_name = json["company_name"] as? String ?? ""
        self.position  = json["position"] as? String ?? ""
        self.email = json["email"] as? String ?? ""
        self.phone = json["phone"] as? String ?? ""
        if let user_json = json["user"] as? [String : AnyObject] {
            self.user = User(withJSON: user_json)
        }
    }

    func create(onSuccess success: ((Void) -> Void)?, onFail fail: ((Error?) -> Void)?) {
        if Secret.apiToken.value == nil { return }
        if !isValid() {
            fail?(nil)
            return
        }
        let request = APIClient.Router.createEmployer(employer: self)
        Alamofire.request(request).responseJSON { response in
            if response.result.isSuccess {
                success?()
            } else {
                fail?(response.result.error)
            }
        }
    }
}
