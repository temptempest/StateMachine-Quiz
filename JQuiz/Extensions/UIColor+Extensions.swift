//
//  UIColor+Extensions.swift
//  JQuiz
//
//  Created by Victor  on 19.02.2022.
//

import UIKit.UIColor

extension UIColor {
    static var randomColor: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
    
    static var randomColorFromSelectedColors:UIColor {
        let colorArray = [UIColor.systemGray2, .systemGray3, .systemGray4]
        return colorArray.shuffled().first ?? .systemBackground
    }
}

//theme.color.bgAlpha
let baseBackgroundColor = UIColor.systemGray6
let quizButtonBackgroundColor = UIColor.tertiarySystemBackground

let baseTextColor: UIColor = {
    if #available(iOS 13, *) {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return UIColor.lightText
            } else {
                return UIColor.darkText
            }
        }
    } else {
        return UIColor.darkText
    }
}()
