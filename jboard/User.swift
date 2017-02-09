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
    public var firstName: String = ""
    public var lastName: String = ""
    public var email: String = ""
    public var phone: String = ""
    public var imageUrl: String = ""
    public var gravatarUrl: String = ""
    public var employer: Bool = false
    public var candidate: Bool = false
    public var facebookUuid: String = ""
    public var facebookToken: String = ""
    public lazy var fullName: String = {
        return "\(self.firstName) \(self.lastName)"
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
        self.firstName = json["first_name"] as? String ?? ""
        self.lastName  = json["last_name"] as? String ?? ""
        self.email = json["email"] as? String ?? ""
        self.imageUrl = json["image_url"] as? String ?? ""
        self.gravatarUrl = json["gravatar_url"] as? String ?? ""
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

    func signUp(onSuccess success: ((String) -> Void)?, onFail fail: ErrorHandler?) {
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
            guard let data = try? Data(contentsOf: self.imageUrl.asURL()) else { return }
            DispatchQueue.main.async {
                completion(UIImage(data: data))
            }
        }
    }

    func hasCompletedProfile() -> Bool {
        return (self.candidate || self.employer)
    }
}
