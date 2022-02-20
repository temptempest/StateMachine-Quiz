//
//  FinishViewController.swift
//  JQuiz
//
//  Created by Victor  on 19.02.2022.
//

import UIKit

class FinishViewController: UIViewController {
    weak var delegate: QuizFlowViewControllerDelegate?
    
    lazy var finishButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.layer.cornerCurve = .continuous
        button.layer.cornerRadius = 12
        button.backgroundColor = quizButtonBackgroundColor
        
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        button.setTitle(finishQuizString, for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc private func buttonTapped() {
        DispatchQueue.main.async {
            self.delegate?.currentState = (self.delegate?.reduce(.startFinalAllResultState, .onDissapear))!
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = baseBackgroundColor
        
        let label = UILabel()
        label.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        label.frame = self.view.frame
        label.textColor =  .systemBlue
        label.text = wayToGoString
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.textAlignment = .center
        view.addSubview(label)
        
        finishButton.frame = CGRect(x: 0, y:  self.view.frame.height - 120, width: view.frame.size.width - 16, height: 60)
        finishButton.center.x = self.view.center.x
        view.addSubview(finishButton)
    }
}

