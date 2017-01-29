//
//  User.swift
//  jboard
//
//  Created by Luis Ezcurdia on 11/5/16.
//  Copyright © 2016 Luis Ezcurdia. All rights reserved.
//

import Foundation
import Alamofire

class User: Model {
    public var id: Int = 0
    public var first_name: String = ""
    public var last_name: String = ""
    public var email: String = ""
    public var phone: String = ""
    public var image_url: String = ""
    public var gravatar_url: String = ""
    public var employer: Bool = false
    public var candidate: Bool = false
    public var facebook_uuid: String = ""
    public var facebook_token: String = ""
    public lazy var full_name: String = {
        return "\(self.first_name) \(self.last_name)"
    }()

    override init() {
        super.init()
        self.rules = [
            "first_name": [.presence],
            "last_name": [.presence],
            "email": [.presence, .formatEmail],
            "phone": [.presence]
        ]
    }

    init(withJSON json: [String : AnyObject]) {
        self.id = json["id"] as? Int ?? 0
        self.first_name = json["first_name"] as? String ?? ""
        self.last_name  = json["last_name"] as? String ?? ""
        self.email = json["email"] as? String ?? ""
        self.image_url = json["image_url"] as? String ?? ""
        self.gravatar_url = json["gravatar_url"] as? String ?? ""
        self.employer = json["employer"] as? Bool ?? false
        self.candidate = json["candidate"] as? Bool ?? false
    }

    class func current(completion: @escaping ((User) -> Void)) {
        let request = APIClient.Router.currentUser
        self.make(request) { data in
            if let json = data["user"] as? [String : AnyObject] {
                completion(User(withJSON: json))
            }
        }
    }

    func signUp(onSuccess success: ((String) -> Void)?, onFail fail: errorHandler?) {
        if Secret.apiToken.value != nil { return }
        if !isValid() {
            fail?(nil)
            return
        }
        let request = APIClient.Router.register(user: self)
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

    func image(completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: self.image_url.asURL())
            DispatchQueue.main.async {
                completion(UIImage(data: data!))
            }
        }
    }

    func hasCompletedProfile() -> Bool {
        return (self.candidate || self.employer)
    }
}
