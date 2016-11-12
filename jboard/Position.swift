//
//  Position.swift
//  jboard
//
//  Created by Luis Ezcurdia on 11/5/16.
//  Copyright © 2016 Luis Ezcurdia. All rights reserved.
//

import Foundation

class Position {
    public var id:Int
    public var title:String
    public var description:String
    public var skillList:Array<String>
    public var company:Company
    public var company_id:Int
    public var company_name:String
    public var contacts:Array<Contact>
    
}

extension Position : JSONAble {}
