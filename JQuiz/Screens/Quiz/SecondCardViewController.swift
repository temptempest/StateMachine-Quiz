//
//  SecondCardViewController.swift
//  JQuiz
//
//  Created by Victor  on 19.02.2022.
//

import UIKit

final class SecondCardViewController: UIViewController {
    weak var delegate: QuizFlowViewControllerDelegate?
    private var kanjiArray:[KanjiModel]! // all words
    private var answerKanji:KanjiModel!
    private var lang:Lang!
    private let spacing:CGFloat = 8
    
    private lazy var progressMaskView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.2)
        view.layer.cornerRadius = 4
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var progressView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 4
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var label :UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = baseTextColor
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [label,buttonStack])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.autoresizingMask = .flexibleHeight
        return stack
    }()
    
    
    private lazy var buttonStack: UIStackView = {
        let topHstack = UIStackView(arrangedSubviews: [firstAnswerButton,secondAnswerButton])
        topHstack.distribution = .fillEqually
        topHstack.spacing = spacing
        
        let bottomHstack = UIStackView(arrangedSubviews: [thirdAnswerButton,forthAnswerButton])
        bottomHstack.distribution = .fillEqually
        bottomHstack.spacing = spacing
        
        let stack = UIStackView(arrangedSubviews: [topHstack,bottomHstack])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = spacing
        return stack
    }()
    
    private lazy var firstAnswerButton: UIButton = {
        let button = UIButton(type: .custom)
        button.titleLabel?.numberOfLines = 3
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title1)
        button.backgroundColor = quizButtonBackgroundColor
        button.setTitleColor(baseTextColor, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.cornerCurve = .continuous
        button.layer.maskedCorners = [.layerMinXMinYCorner]
        button.tag = 1
        button.addTarget(self, action: #selector(answerButtonDidTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var secondAnswerButton: UIButton = {
        let button = UIButton(type: .custom)
        button.titleLabel?.numberOfLines = 3
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title1)
        button.backgroundColor = quizButtonBackgroundColor
        button.layer.cornerRadius = 12
        button.layer.cornerCurve = .continuous
        button.layer.maskedCorners = [.layerMaxXMinYCorner]
        button.setTitleColor(baseTextColor, for: .normal)
        button.tag = 2
        button.addTarget(self, action: #selector(answerButtonDidTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var thirdAnswerButton: UIButton = {
        let button = UIButton(type: .custom)
        button.titleLabel?.numberOfLines = 3
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title1)
        button.backgroundColor = quizButtonBackgroundColor
        button.setTitleColor(baseTextColor, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.cornerCurve = .continuous
        button.layer.maskedCorners = [.layerMinXMaxYCorner]
        button.tag = 3
        button.addTarget(self, action: #selector(answerButtonDidTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    
    private lazy var forthAnswerButton: UIButton = {
        let button = UIButton(type: .custom)
        button.titleLabel?.numberOfLines = 3
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title1)
        button.backgroundColor = quizButtonBackgroundColor
        button.setTitleColor(baseTextColor, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.cornerCurve = .continuous
        button.layer.maskedCorners = [.layerMaxXMaxYCorner]
        button.tag = 4
        button.addTarget(self, action: #selector(answerButtonDidTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    
    private lazy var speakerButton: UIButton = {
        let button = UIButton(type: .custom)
        let image = UIImage(systemName: "speaker.wave.2.fill")
        button.setImage(image, for: .normal)
        button.tintColor = .systemBlue
        button.backgroundColor = quizButtonBackgroundColor
        button.layer.cornerRadius = 12
        button.layer.cornerCurve = .continuous
        button.addTarget(self, action: #selector(sayJapanese), for: .touchUpInside)
        return button
    }()
    
    @objc private func sayJapanese() {
        say(lang: "ja", text: self.answerKanji.desc)
    }
    
    
    init(kanjiArray:[KanjiModel], answerKanji: KanjiModel, lang:Lang) {
        self.kanjiArray = kanjiArray
        self.answerKanji = answerKanji
        self.lang = lang
        super.init(nibName: nil, bundle: nil)
    }
    
    func configure(kanjiArray:[KanjiModel], answerKanji: KanjiModel, lang:Lang) {
        self.kanjiArray = kanjiArray
        self.answerKanji = answerKanji
        self.lang = lang
        self.setData()
        sayJapanese()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        self.setData()
        sayJapanese()
    }
    
    private func setupUI() {
        view.backgroundColor = baseBackgroundColor
        mainStack.frame = CGRect(x: 0, y: 0, width: view.frame.size.width - 16, height: view.frame.size.height * 0.8)
        mainStack.center = self.view.center
        mainStack.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        view.addSubview(mainStack)
        
        progressMaskView.autoresizingMask = [.flexibleWidth]
        progressMaskView.frame = CGRect(x: 8, y: view.frame.size.height * 0.1, width: view.frame.size.width - 16, height: 8)
        
        view.addSubview(progressMaskView)
        progressView.frame = CGRect(x: 8, y: view.frame.size.height * 0.1, width: 0, height: 8)
        progressView.autoresizingMask = [.flexibleWidth]
        view.addSubview(progressView)
        
        view.addSubview(speakerButton)
        speakerButton.autoresizingMask = [.flexibleLeftMargin]
        speakerButton.frame = CGRect(x: view.frame.size.width - spacing - 40, y: view.frame.size.height * 0.1 + spacing + spacing, width: 40, height: 40)
        speakerButton.center.x = self.view.center.x
        
        buttonStack.frame = CGRect(x: 0, y: 0, width: view.frame.width - 16, height: view.frame.height * 0.5)
        buttonStack.center.x = self.view.center.x
        buttonStack.center.y = self.view.center.y * 1.3
        buttonStack.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    private func setData() {
        var labelString = "\(answerKanji.kanji)"
        labelString += "\n"
        labelString += "\(answerKanji.desc)"
        label.text = labelString
        let kanji = kanjiArray.shuffled()
        firstAnswerButton.setTitle(getStringFromKanji(kanji: kanji[0], lang: lang).replacingOccurrences(of: " ", with: " \n"), for: .normal)
        firstAnswerButton.titleLabel?.magicAutoResize()
        secondAnswerButton.setTitle(getStringFromKanji(kanji: kanji[1], lang: lang).replacingOccurrences(of: " ", with: " \n"), for: .normal)
        secondAnswerButton.titleLabel?.magicAutoResize()
        thirdAnswerButton.setTitle(getStringFromKanji(kanji: kanji[2], lang: lang).replacingOccurrences(of: " ", with: " \n"), for: .normal)
        thirdAnswerButton.titleLabel?.magicAutoResize()
        forthAnswerButton.setTitle(getStringFromKanji(kanji: kanji[3], lang: lang).replacingOccurrences(of: " ", with: " \n"), for: .normal)
        forthAnswerButton.titleLabel?.magicAutoResize()
    }
    
}


extension SecondCardViewController {
    @objc fileprivate func answerButtonDidTapped(_ sender: UIButton) {
        var isCorrect = false
        
        firstAnswerButton.isUserInteractionEnabled = false
        secondAnswerButton.isUserInteractionEnabled = false
        thirdAnswerButton.isUserInteractionEnabled = false
        forthAnswerButton.isUserInteractionEnabled = false
        let answerText = getStringFromKanji(kanji: answerKanji, lang: lang).replacingOccurrences(of: " ", with: " \n")
        if sender.titleLabel?.text == answerText {
            sender.backgroundColor = .systemGreen
            isCorrect = true
        }
        else {
            addVibration()
            sender.backgroundColor = .systemPink
            sender.shake(duration: 0.4)
            if firstAnswerButton.titleLabel?.text == answerText {
                firstAnswerButton.backgroundColor = .systemGreen
            }
            else if secondAnswerButton.titleLabel?.text == answerText {
                secondAnswerButton.backgroundColor = .systemGreen
            }
            else if thirdAnswerButton.titleLabel?.text == answerText {
                thirdAnswerButton.backgroundColor = .systemGreen
            }
            else if forthAnswerButton.titleLabel?.text == answerText {
                forthAnswerButton.backgroundColor = .systemGreen
            }
        }
        
        UIView.animate(withDuration: isCorrect ? 0.5 : 1.0, delay: 0, options: .curveEaseInOut) {
            let onePercent = self.progressMaskView.frame.width / CGFloat(self.delegate!.totalKanjiIndex) // / 5
            self.progressView.frame.size.width = (onePercent * CGFloat(self.delegate!.currentIndex + 1))
        } completion: { _ in
            ///
            self.firstAnswerButton.backgroundColor = quizButtonBackgroundColor
            self.secondAnswerButton.backgroundColor = quizButtonBackgroundColor
            self.thirdAnswerButton.backgroundColor = quizButtonBackgroundColor
            self.forthAnswerButton.backgroundColor = quizButtonBackgroundColor
            self.firstAnswerButton.isUserInteractionEnabled = true
            self.secondAnswerButton.isUserInteractionEnabled = true
            self.thirdAnswerButton.isUserInteractionEnabled = true
            self.forthAnswerButton.isUserInteractionEnabled = true
            ///
            self.delegate?.currentState = (self.delegate?.reduce(self.delegate!.currentState, .questionSecondAnswered(kanji: self.answerKanji, correct: isCorrect)))!
        }
    }
}
