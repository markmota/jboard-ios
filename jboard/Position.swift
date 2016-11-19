//
//  Position.swift
//  jboard
//
//  Created by Luis Ezcurdia on 11/5/16.
//  Copyright © 2016 Luis Ezcurdia. All rights reserved.
//

import Foundation
import Alamofire

class Position {
    public var id:Int = 0
    public var title:String = ""
    public var description:String = ""
    public var skillList:Array<String> = []
    public var company:Company? {
        didSet {
            if let cid = self.company?.id {
                self.company_id = cid
            }
            if let cname = self.company?.name {
                self.company_name = cname
            }
        }
    }
    public var company_id:Int = 0
    public var company_name:String = ""
    public var contacts:Array<Contact> = []
    
    class func all(completion: (([Position]) -> Void)?) {
        let request = try! APIClient.Router.positions.asURLRequest()
        Alamofire.request(request).responseJSON { response in
            var out : [Position] = []
            if response.result.isSuccess, let data = response.result.value as? [String : AnyObject], let array = data["positions"] as? [[String : AnyObject]] {
                for json in array {
                    out.append(Position(withJSON: json))
                }
            }
            if let completionBlock = completion {
                completionBlock(out)
            }
        }
    }
    
    init(withJSON json: [String : AnyObject]) {
        if let id = json["id"] as? Int {
            self.id = id
        }
        if let title = json["title"] as? String {
            self.title = title
        }
        if let description = json["description"] as? String {
            self.description = description
        }
        if let skillList = json["skill_list"] as? [String] {
            self.skillList = skillList
        }
        if let companyJSON = json["company"] as? [String:AnyObject] {
            self.company = Company(withJSON: companyJSON)
        }
    }
}

extension Position : JSONAble {}
