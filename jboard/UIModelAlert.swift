//
//  UIModelAlert.swift
//  jboard
//
//  Created by Luis Ezcurdia on 11/21/16.
//  Copyright © 2016 Luis Ezcurdia. All rights reserved.
//

import Foundation
import SCLAlertView

protocol UIModelAlert {}

extension UIModelAlert {
    func errorAlert(model: Model, error: Error?) {
        let message = error?.localizedDescription ?? (!model.isValid() ? model.errors.first : "Error desconocido")
        SCLAlertView().showError("Error", subTitle: message!)
    }
}
