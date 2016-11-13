//
//  Employer.swift
//  jboard
//
//  Created by Luis Ezcurdia on 11/5/16.
//  Copyright © 2016 Luis Ezcurdia. All rights reserved.
//

import Foundation

class Employer {
    public var id:Int = 0
    public var company_id:Int = 0
    public var company_name:String = ""
    public var name:String = ""
    public var position:String = ""
    public var email:String = ""
    public var phone:String = ""
    public var userData:Bool = false
    public var user:User?
}

extension Employer : JSONAble {}
