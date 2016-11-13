//
//  History.swift
//  jboard
//
//  Created by Luis Ezcurdia on 11/5/16.
//  Copyright © 2016 Luis Ezcurdia. All rights reserved.
//

import Foundation

class History {
    public var id:Int = 0
    public var viewableType:String = ""
    public var viewableIds:Array<Int> = []
}

extension History : JSONAble {}
