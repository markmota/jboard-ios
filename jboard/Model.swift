//
//  model.swift
//  jboard
//
//  Created by Luis Ezcurdia on 11/21/16.
//  Copyright © 2016 Luis Ezcurdia. All rights reserved.
//

import Foundation

class Model {
    var rules: [String:[Validation.rule]] = [:]
    init() {}
}

extension Model : JSONAble {}
extension Model : Validable {
    func isValid() -> Bool {
        return self.errors.isEmpty
    }
}
