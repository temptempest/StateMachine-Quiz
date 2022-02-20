//
//  MenuVC.swift
//  JQuiz
//
//  Created by Victor  on 19.02.2022.
//

import UIKit

final class MainMenuViewController: UIViewController {
    
    private lazy var isEnableKanjiSwitcher: UISwitch = {
        let switcher = UISwitch()
        switcher.onTintColor = .systemBlue
        switcher.isOn = true
        switcher.addTarget(self, action: #selector(switcherValueChanged), for: .valueChanged)
        return switcher
    }()
    
    private lazy var startButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.layer.cornerCurve = .continuous
        button.layer.cornerRadius = 12
        button.backgroundColor = quizButtonBackgroundColor
        
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        button.setTitle(startQuizString, for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.text = "Enable Kanji"
        return label
    }()
    
    private lazy var textView:UITextView = {
        let textView = UITextView()
        textView.font = UIFont.preferredFont(forTextStyle: .caption1)
        textView.backgroundColor = .systemBlue
        textView.layer.cornerCurve = .continuous
        textView.layer.cornerRadius = 12
        textView.textColor = .white
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setData(hasKanji: true)
    }
    
    private func setData(hasKanji:Bool = false) {
        var totalString = " ------------------WORDS------------------"
        wordsTest.map { $0 }.forEach { word in
            totalString += "\n \(word.kanji) - \(word.hiragana) - \(word.english)\n "
        }
        
        if hasKanji {
            totalString +=  "\n ------------------KANJI------------------"
            kanjiTest.map { $0 }.forEach { kanji in
                totalString += "\n \(kanji.kanji) - \(kanji.desc) - \(kanji.english)\n "
            }
        }
        
        textView.text = totalString
        textView.sizeToFit()
        textView.frame.size.width = self.view.frame.width - 16
    }
    
    private func setupUI() {
        //TODO: - Challenge: without layout constraints
        view.backgroundColor = baseBackgroundColor
       
        startButton.frame = CGRect(x: 0, y:self.view.frame.height - 120, width: view.frame.size.width - 16, height: 60)
        startButton.center.x = self.view.center.x
        view.addSubview(startButton)
        
        label.frame = CGRect(x: 8, y: self.view.frame.height - 120 - 50, width: 100, height: 30)
        view.addSubview(label)
        
        isEnableKanjiSwitcher.frame = CGRect(x: 108, y: self.view.frame.height - 120 - 50, width: 40, height: 30)
        isEnableKanjiSwitcher.center.x = self.view.center.x
        view.addSubview(isEnableKanjiSwitcher)
        
        textView.frame = CGRect(x: 0, y: self.view.frame.height * 0.05, width: view.frame.width - 16, height: view.frame.width - 16)
        textView.center.x = self.view.center.x
        view.addSubview(textView)
    }
}

//MARK: - Actions
extension MainMenuViewController {
    @objc private func switcherValueChanged(sender:AnyObject) {
        setData(hasKanji: sender.isOn)
    }
    
    @objc private func buttonTapped() {
        DispatchQueue.main.async {
            let vc = QuizFlowViewController(
                wordsArray: wordsTest, kanjiArray: kanjiTest, translatedLang: .english, withKanji: self.isEnableKanjiSwitcher.isOn)
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false, completion: nil)
        }
    }
}
