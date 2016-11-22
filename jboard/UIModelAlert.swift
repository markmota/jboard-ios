//
//  UIModelAlert.swift
//  jboard
//
//  Created by Luis Ezcurdia on 11/21/16.
//  Copyright © 2016 Luis Ezcurdia. All rights reserved.
//

import Foundation

protocol UIModelAlert {}

extension UIModelAlert {
    func errorAlert(model: Model, error: Error?) -> UIAlertController {
        let message = error?.localizedDescription ?? (!model.isValid() ? model.errors.first : "Error desconocido")
        let alertController = UIAlertController(title: "Mensaje", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        alertController.addAction(action)
        return alertController
    }
}
