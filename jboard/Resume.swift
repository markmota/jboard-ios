//
//  Resume.swift
//  jboard
//
//  Created by Luis Ezcurdia on 11/5/16.
//  Copyright © 2016 Luis Ezcurdia. All rights reserved.
//

import Foundation
import Alamofire

class Resume: Model {
    public var id: Int = 0
    public var startWorkingAt: Date = Date()
    public var bio: String = ""
    public var user: User?
    public var skillList: [String] = []

    class func all(completion: (([Resume]) -> Void)?) {
        let request = APIClient.Router.resumes
        self.make(request) { data in
            var out: [Resume] = []
            if let array = data["resumes"] as? [[String : AnyObject]] {
                for json in array {
                    out.append(Resume(withJSON: json))
                }
            }
            completion?(out)
        }
    }

    override init() {
        super.init()
        self.rules = [
            "start_working_at": [.presence],
            "bio": [.presence]
        ]
    }

    init(withJSON json: [String : AnyObject]) {
        self.id = json["id"] as? Int ?? 0
        self.startWorkingAt = (json["start_working_at"] as? String ?? "").toDate() ?? Date()
        self.bio = json["bio"] as? String ?? ""
        self.skillList = json["skill_list"] as? [String] ?? []
        self.user = User(withJSON: json["user"] as? [String : AnyObject] ?? [:])
    }

    class func current(completion: @escaping (Resume) -> Void) {
        let request = APIClient.Router.resume
        self.make(request) { data in
            if let json = data["resume"] as? [String : AnyObject] {
                completion(Resume(withJSON: json))
            }
        }
    }

    func create(update: Bool, onSuccess success: JsonHandler?, onFail fail: ErrorHandler?) {
        if Secret.apiToken.value == nil { return }
        if !isValid() {
            fail?(nil)
            return
        }
        let request: URLRequestConvertible
        if update {
            request = APIClient.Router.updateResume(resume: self)
        } else {
            request = APIClient.Router.createResume(resume: self)
        }
        self.make(request, onSuccess: success, onFail: fail)
    }

    func yearsOfExperience() -> Int {
        return Date().years(from: self.startWorkingAt)
    }

    func setSkillListFrom(text: String) {
        self.skillList = Array(Set(text.components(separatedBy: ","))).filter { $0 != "" }
    }
}
