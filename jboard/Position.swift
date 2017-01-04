//
//  Position.swift
//  jboard
//
//  Created by Luis Ezcurdia on 11/5/16.
//  Copyright © 2016 Luis Ezcurdia. All rights reserved.
//

import Foundation
import Alamofire

class Position : Model {
    public var id:Int = 0
    public var match:Float = 0.0
    public var title:String = ""
    public var description:String = ""
    public var skillList:Array<String> = []
    public var company:Company? {
        didSet {
            self.company_id = self.company?.id ?? 0
            self.company_name = self.company?.name ?? ""
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
            completion?(out)
        }
    }
    
    class func find(id: Int, completion: ((Position) -> Void)?) {
        let request = try! APIClient.Router.position(id: id).asURLRequest()
        Alamofire.request(request).responseJSON { response in
            if response.result.isSuccess, let data = response.result.value as? [String : AnyObject]{
                guard let json = data["position"] as? [String : AnyObject] else { return }
                let position = Position(withJSON: json)
                if let match = data["match"] as? Float {
                    position.match = match * 100.0
                }
                completion?(position)
            }
        }
    }
    
    init(withJSON json: [String : AnyObject]) {
        self.id = json["id"] as? Int ?? 0
        self.title = json["title"] as? String ?? ""
        self.description = json["description"] as? String ?? ""
        self.skillList = json["skill_list"] as? [String] ?? []
        if let companyJSON = json["company"] as? [String:AnyObject] {
            self.company = Company(withJSON: companyJSON)
        }
    }
}
