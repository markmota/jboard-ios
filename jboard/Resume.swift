//
//  Resume.swift
//  jboard
//
//  Created by Luis Ezcurdia on 11/5/16.
//  Copyright © 2016 Luis Ezcurdia. All rights reserved.
//

import Foundation
import Alamofire

class Resume : Model {
    public var id:Int = 0
    public var start_working_at : Date = Date()
    public var bio:String = ""
    public var user:User?
    public var skill_list:Array<String> = []
    
    class func all(completion: (([Resume]) -> Void)?) {
        let request = APIClient.Router.resumes
        Alamofire.request(request).responseJSON { response in
            var out : [Resume] = []
            if response.result.isSuccess, let data = response.result.value as? [String : AnyObject], let array = data["resumes"] as? [[String : AnyObject]] {
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
            "start_working_at" : [.presence],
            "bio" : [.presence]
        ]
    }
    
    init(withJSON json: [String : AnyObject]) {
        self.id = json["id"] as? Int ?? 0
        self.start_working_at = Model.parseDate(json["start_working_at"])
        self.bio = json["bio"] as? String ?? ""
        self.skill_list = json["skill_list"] as? [String] ?? []
        self.user = User(withJSON: json["user"] as? [String : AnyObject] ?? [:])
    }
    
    class func current(completion: @escaping (Resume) -> Void) {
        let request = APIClient.Router.resume
        Alamofire.request(request).responseJSON { (response) in
            if response.result.isSuccess,let data = response.result.value as? [String : AnyObject] {
                guard let json = data["resume"] as? [String : AnyObject] else { return }
                completion(Resume(withJSON: json))
            }
        }
    }
    
    func create(onSuccess success: ((Void) -> Void)?, onFail fail: ((Error?) -> Void)?) {
        if Secret.apiToken.value == nil { return }
        if !isValid() {
            fail?(nil)
            return
        }
        let request = try! APIClient.Router.createResume(resume: self).asURLRequest()
        Alamofire.request(request).responseJSON { response in
            debugPrint(response.result)
            if response.result.isSuccess {
                success?()
            } else {
                fail?(response.result.error)
            }
        }
    }
    
    func years_of_experience() -> Int {
        return Date().years(from: self.start_working_at)
    }
    
    func setSkillListFrom(text: String){
        self.skill_list = Array(Set(text.components(separatedBy: ","))).filter { $0 != "" }
    }
    
}
