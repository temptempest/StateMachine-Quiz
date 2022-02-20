//
//  UILabel+Extension.swift
//  JQuiz
//
//  Created by Victor  on 19.02.2022.
//

import UIKit.UILabel

extension UILabel {
    func magicAutoResize() {
        lineBreakMode = .byClipping // <--
        adjustsFontSizeToFitWidth = true
    }
}
