//
//  User.swift
//  jboard
//
//  Created by Luis Ezcurdia on 11/5/16.
//  Copyright © 2016 Luis Ezcurdia. All rights reserved.
//

import Foundation

class User {
    public var id:Int = 0
    public var first_name:String = ""
    public var last_name:String = ""
    public var email:String = ""
    public var phone:String = ""
    public var imageUrl:String = ""
    public var gravatarUrl:String = ""
    public var employer:Bool = false
    public var candidate:Bool = false
    public var facebook_uuid:String = ""
    public var facebook_token:String = ""
    
    
}

extension User : JSONAble {}
