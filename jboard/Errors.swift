//
//  APIError.swift
//  jboard
//
//  Created by Luis Ezcurdia on 1/17/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import Foundation

enum CustomErrors : Error {
    case api(json: [String:AnyObject]?)
}

extension CustomErrors: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .api(let json):
            if let err = json?["error"] as? [String:AnyObject], let msg = err["messages"] as? [String] {
                return NSLocalizedString(msg[0], comment: "api error")
            } else {
                return NSLocalizedString("Error desconocido", comment: "unkown api error")
            }
        }
    }
}
