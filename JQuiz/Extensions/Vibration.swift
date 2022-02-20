//
//  Vibration.swift
//  JQuiz
//
//  Created by Victor  on 19.02.2022.
//

import UIKit

func addVibration() {
  let generator = UIImpactFeedbackGenerator(style: .light)
  generator.impactOccurred()
}
