//
//  Validation.swift
//  jboard
//
//  Created by Luis Ezcurdia on 11/20/16.
//  Copyright © 2016 Luis Ezcurdia. All rights reserved.
//

import Foundation

struct Validation {
    enum regex: String {
        case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    }

    enum rule {
        case presence
        case length(size : Int)
        case formatEmail

        var error: String {
            switch self {
            case .presence: return "deve estar presente"
            case .length(let size): return "debe tener al menos \(size) caracteres"
            case .formatEmail: return "correo electronico invalido"
            }
        }

        func isValid(_ value : Any?) -> Bool {
            switch self {
            case .presence:
                if let string = value as? String {
                    return !string.isEmpty
                } else {
                    return value != nil
                }
            case .length(let size):
                guard let string = value as? String else { return false }
                return string.characters.count >= size
            case .formatEmail:
                guard let string = value as? String else { return false }
                let emailTest = NSPredicate(format:"SELF MATCHES %@", Validation.regex.email.rawValue)
                return emailTest.evaluate(with: string)
            }
        }
    }
}
