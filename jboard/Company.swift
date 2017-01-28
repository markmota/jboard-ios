//
//  Company.swift
//  jboard
//
//  Created by Luis Ezcurdia on 11/5/16.
//  Copyright © 2016 Luis Ezcurdia. All rights reserved.
//

import Foundation

class Company: Model {
    public var id: Int = 0
    public var name: String = ""

    init(withJSON json: [String : AnyObject]) {
        if let id = json["id"] as? Int {
            self.id = id
        }
        if let name = json["name"] as? String {
            self.name = name
        }
    }
}
