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
    func toDict(exclude: [String]) -> [String:Any] {
        var dict = [String: Any]()
        let mirror = Mirror(reflecting: self)
        for child in mirror.children {
            if let key = child.label?.snakeCase, !exclude.contains(key) {
//                if (child.value as Any).responds(Selector(("toDic"))) {
//                    dict[key] = (child.value as AnyObject).toDic(exclude: [])
//                } else {
                    dict[key] = child.value
//                }
            }
        }
        return dict
    }
}
