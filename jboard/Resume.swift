//
//  Resume.swift
//  jboard
//
//  Created by Luis Ezcurdia on 11/5/16.
//  Copyright © 2016 Luis Ezcurdia. All rights reserved.
//

import Foundation

class Resume {
    public var id:Int
    public var bio:String
    public var user:User
    public var skillList:ListString
}

extension Resume : JSONAble {}
