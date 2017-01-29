//
//  Validable.swift
//  jboard
//
//  Created by Luis Ezcurdia on 11/20/16.
//  Copyright © 2016 Luis Ezcurdia. All rights reserved.
//

import Foundation
protocol Validable {
    var rules: [String:[Validation.rule]] { get set }
    func isValid() -> Bool
}

extension Validable {
    var errors: [String] {
        get {
            var errors = [String]()
            if rules.isEmpty { return [] }
            let mirror = Mirror(reflecting: self)
            for child in mirror.children {
                if let key = child.label?.snakeCase, let attrRules = rules[key], !attrRules.isEmpty {
                    for rule in attrRules {
                        if !rule.isValid(child.value) {
                            errors.append("\(key) : \(rule.error)")
                        }
                    }
                }
            }
            return errors
        }
    }
}
