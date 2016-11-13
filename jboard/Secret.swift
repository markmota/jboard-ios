//
//  Secret.swift
//  jboard
//
//  Created by Luis Ezcurdia on 11/5/16.
//  Copyright © 2016 Luis Ezcurdia. All rights reserved.
//

import Foundation
import SAMKeychain

enum Secret {
    static let account        = "org.rightmonkey.jboard"
    static let apiService     = "jboardService"
    
    case apiToken
    
    var value : String? {
        switch self {
        case .apiToken:
            return SAMKeychain.password(forService: Secret.apiService, account: Secret.account)
        }
    }
}
