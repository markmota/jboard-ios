//
//  JSONAble.swift
//  jboard
//
//  Created by Luis Ezcurdia on 11/5/16.
//  Copyright © 2016 Luis Ezcurdia. All rights reserved.
//

import Foundation
protocol JSONAble {}

extension JSONAble {
    func toDict(exclude:Array<String>) -> [String:Any] {
        var dict = [String:Any]
        let mirror = Mirror(reflecting: self)
        for child in mirror.children {
            if let key = child.label, !exclude.contains(key) {
                if child.value.respondsToSelector(Selector("toDic")) {
                    dict[key] = child.value.toDic(exclude: [])
                } else {
                    dict[key] = child.value
                }
            }
        }
        return dict
    }
}
