//
//  Resume.swift
//  jboard
//
//  Created by Luis Ezcurdia on 11/5/16.
//  Copyright © 2016 Luis Ezcurdia. All rights reserved.
//

import Foundation

class Resume : Model {
    public var id:Int = 0
    public var bio:String = ""
    public var user:User?
    public var skillList:Array<String> = []
}
