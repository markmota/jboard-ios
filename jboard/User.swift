//
//  User.swift
//  jboard
//
//  Created by Luis Ezcurdia on 11/5/16.
//  Copyright © 2016 Luis Ezcurdia. All rights reserved.
//

import Foundation

class User {
    public var id:Int
    public var firstName:String
    public var lastName:String
    public var email:String
    public var phone:String
    public var imageUrl:String
    public var gravatarUrl:String
    public var employer:Boolean
    public var candidate:Boolean
    
    public var facebook_uuid:String
    public var facebook_token:String
}

extension User : JSONAble {}
