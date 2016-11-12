//
//  Contact.swift
//  jboard
//
//  Created by Luis Ezcurdia on 11/5/16.
//  Copyright © 2016 Luis Ezcurdia. All rights reserved.
//

import Foundation

class Contact {
    public var mainContact:Boolean
    public var id:Int
    public var name:String
    public var position:String
    public var email:String
    public var phone:String
}

extension Contact : JSONAble {}
