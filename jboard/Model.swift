//
//  model.swift
//  jboard
//
//  Created by Luis Ezcurdia on 11/21/16.
//  Copyright © 2016 Luis Ezcurdia. All rights reserved.
//

import Foundation

class Model {
    var rules : [String:[Validation.rule]] = [:]
    init() {}
    class func parseDate(_ string: Any?) -> Date {
        guard let str = string as? String else { return Date() }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return formatter.date(from: str) ?? Date()
    }
}

extension Model : JSONAble {}
extension Model : Validable {
    func isValid() -> Bool {
        return self.errors.isEmpty
    }
}
