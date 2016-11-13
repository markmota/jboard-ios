//
//  Bookmark.swift
//  jboard
//
//  Created by Luis Ezcurdia on 11/5/16.
//  Copyright © 2016 Luis Ezcurdia. All rights reserved.
//

import Foundation

class Bookmark {
    public var id:Int = 0
    public var status:String = ""
    public var match:Double = 0.0
    public var resumeId:Int = 0
    public var position:Position?
}

extension Bookmark : JSONAble {}
