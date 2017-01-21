//
//  Bookmark.swift
//  jboard
//
//  Created by Luis Ezcurdia on 11/5/16.
//  Copyright © 2016 Luis Ezcurdia. All rights reserved.
//

import Foundation

class Bookmark : Model {
    public var id:Int = 0
    public var status:String = ""
    public var match:Double = 0.0
    public var resume_id:Int = 0
    public var position:Position?
    
    override init() {
        super.init()
    }
    
    init(withJSON json: [String:AnyObject]) {
        self.id = json["id"] as? Int ?? 0
        self.status = json["status"] as? String ?? ""
        self.match = json["match"] as? Double ?? 0.0
        self.resume_id = json["resume_id"] as? Int ?? 0
        if let positionJSON = json["position"] as? [String:AnyObject] {
            self.position = Position(withJSON: positionJSON)
        }
    }
}
