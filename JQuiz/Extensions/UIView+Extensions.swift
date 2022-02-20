//
//  CustomShakeAnimations.swift
//  JQuiz
//
//  Created by Victor  on 18.02.2022.
//https://stackoverflow.com/questions/46556422/how-to-make-uibutton-shake-on-tap

import UIKit.UIView

extension UIView {
    
    // Using SpringWithDamping -
    func shake(duration: TimeInterval = 0.5, xValue: CGFloat = 12, yValue: CGFloat = 0) {
        self.transform = CGAffineTransform(translationX: xValue, y: yValue)
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: nil)
    }
}


