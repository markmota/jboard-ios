//
//  Bookmark.swift
//  jboard
//
//  Created by Luis Ezcurdia on 11/5/16.
//  Copyright © 2016 Luis Ezcurdia. All rights reserved.
//

import Foundation

class Bookmark {
    public var id:Int
    public var status:String
    public var match:Double
    public var resumeId:Int
    public var position:Position
}

extension Bookmark : JSONAble {}
