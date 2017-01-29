//
//  ScrollKerboardView.swift
//  jboard
//
//  Created by Luis Ezcurdia on 1/5/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import UIKit

class ScrollKerboardView: UIScrollView {
    var isKeyboardUp: Bool = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        listenKeyboard()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        listenKeyboard()
    }

    func listenKeyboard() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardDidAppear),
                                               name: .UIKeyboardDidShow,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillDisppear),
                                               name: .UIKeyboardWillHide,
                                               object: nil)
    }

    func keyboardDidAppear(notification: NSNotification) {
        if isKeyboardUp { return }
        self.adjust(true, withNotification: notification)
    }

    func keyboardWillDisppear(notification: NSNotification) {
        self.adjust(false, withNotification: notification)
    }

    func adjust(_ increase: Bool, withNotification notification: NSNotification) {
        guard let info = notification.userInfo else { return }
        let value = info[UIKeyboardFrameEndUserInfoKey] as! NSValue
        let keyboardFrame = value.cgRectValue
        var size = self.contentSize
        if increase {
            size.height += keyboardFrame.size.height
        } else {
            size.height -= keyboardFrame.size.height
        }
        self.contentSize = size
        isKeyboardUp = increase
    }

//    func resignFirsResponders() {
//        for subview in self.subviews {
//            if subview is UITextField {
//                if let view = subview as? UITextField, view.isFirstResponder {
//                    view.resignFirstResponder()
//                    return
//                }
//            }
//        }
//    }

}
