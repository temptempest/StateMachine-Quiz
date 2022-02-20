//
//  ViewController.swift
//  JQuiz
//
//  Created by Victor  on 18.02.2022.
//

import UIKit

protocol QuizFlowViewControllerDelegate: AnyObject {
    var currentState: QuizViewModelState { get set }
    var translatedLang: Lang { get }
    var currentIndex: Int { get }
    var totalIndex: Int { get }
    var totalKanjiIndex: Int { get }
    func reduce(_ state: QuizViewModelState, _ event: QuizViewModelEvent) -> QuizViewModelState
}

final class QuizFlowViewController: UIViewController, QuizFlowViewControllerDelegate {
    var translatedLang: Lang
    var currentState: QuizViewModelState = .start
    var currentIndex = 0
    var totalIndex = 0
    var totalKanjiIndex = 0
    private var withKanji = false
    fileprivate var wordsArray:[WordModel]
    fileprivate var kanjiArray:[KanjiModel]
    
    fileprivate var currentVC:UIViewController?
    fileprivate var firstVC: FirstCardViewController!
    fileprivate var secondVC: SecondCardViewController!
    
    init(wordsArray:[WordModel],kanjiArray:[KanjiModel],translatedLang:Lang, withKanji:Bool) {
        self.withKanji = withKanji
        self.wordsArray = wordsArray
        self.kanjiArray = kanjiArray
        self.translatedLang = translatedLang
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue//baseBackgroundColor
        currentState = reduce(currentState, .onAppear)
    }
    
    ///
    
    private func presentFirstCardAndDissmissPrevious() {
        totalIndex = wordsArray.count // for check only
        setupFirstCard(model: wordsArray, currentIndex: currentIndex) //set firstVC with index
        dismissAndPresentNewVC(newVC: self.firstVC, animated: false) //update view
    }
    
    private func updateFirstCard() {
        setupFirstCard(model: wordsArray, currentIndex: currentIndex, justUpdateCard: true)
    }
    
    ///
    
    private func presentSecondCardAndDissmissPrevious() {
        totalKanjiIndex = kanjiArray.count
        setupSecondCard(model: kanjiArray, currentIndex: currentIndex)
        dismissAndPresentNewVC(newVC: secondVC, animated: false)
    }
    
    private func updateSecondCard() {
        setupSecondCard(model: kanjiArray, currentIndex: currentIndex, justUpdateCard: true)
    }
    
    private func setupSecondCard(model:[KanjiModel], currentIndex:Int, justUpdateCard:Bool = false) {
        
        let answerKanji = model[currentIndex]
        
        if justUpdateCard {
            secondVC.configure(kanjiArray: kanjiArray, answerKanji: answerKanji, lang: translatedLang)
        } else {
            secondVC = SecondCardViewController(kanjiArray: kanjiArray, answerKanji: answerKanji, lang: translatedLang)
            secondVC.delegate = self
            secondVC.modalPresentationStyle = .fullScreen
        }
    }
    
    private func presentFinishCard() {
        let vc = FinishViewController()
        vc.delegate = self
        vc.modalPresentationStyle = .fullScreen
        dismissAndPresentNewVC(newVC: vc, animated: false)
    }
    
    private func setupFirstCard(model:[WordModel], currentIndex:Int, justUpdateCard:Bool = false) {
        let answerWord = model[currentIndex]
        var tempModel = model
        tempModel.remove(at: currentIndex)
        var uncorrectedWordModel = tempModel
        let firstUncorrectWord: WordModel = uncorrectedWordModel.shuffled().first!
        let firstWordIndex:Int = uncorrectedWordModel.firstIndex(of: firstUncorrectWord)!
        uncorrectedWordModel.remove(at: firstWordIndex)
        
        let secondUncorrectWord:WordModel = uncorrectedWordModel.shuffled().first!
        let inputWordsForQuiz = [answerWord, firstUncorrectWord, secondUncorrectWord].shuffled()
        
        guard inputWordsForQuiz.count > 2 else { print("less than 3 words"); fatalError() }
        
        if justUpdateCard {
            firstVC.configure(wordsArray: inputWordsForQuiz, answerWord: answerWord, lang: translatedLang)
        } else {
            firstVC = FirstCardViewController(wordsArray: inputWordsForQuiz, answerWord: answerWord, lang: translatedLang)
            firstVC.delegate = self
            firstVC.modalPresentationStyle = .fullScreen
        }
    }
    
    private func dismissAndPresentNewVC(newVC:UIViewController, animated: Bool = false) {
        DispatchQueue.main.asyncAfter(deadline:.now() + 0.5) { //0.5 base for animation
            self.currentVC?.dismiss(animated: animated)
            self.currentVC = newVC
            self.currentVC!.modalPresentationStyle = .fullScreen
            self.present(self.currentVC!, animated: animated)
        }
    }
}

extension QuizFlowViewController {
    
    func reduce(_ state: QuizViewModelState, _ event: QuizViewModelEvent) -> QuizViewModelState {
        switch event {
            
        case .onAppear:
            presentFirstCardAndDissmissPrevious()
            return .startFirstState
            
        case .questionFirstAnswered(word: let word, correct: let correct):
            print("=1 isRight:",correct,"|", word.english)
            // FIXME: LOOK HERE
            // here in future ...
            // save results (statistic)
            // check if more uncorrect answers -> Repeat this step
            // if correct -> Go to next step
            
            //FIXME: <-- START
            currentIndex += 1
            
            if currentIndex < wordsArray.count {
                updateFirstCard() //change word in FirstVC == wordArray[currentIndex]
                return .startFirstState
            }
            else {
                currentIndex = 0
                if withKanji {
                    presentSecondCardAndDissmissPrevious()
                } else {
                    presentFinishCard()
                }
                //dismiss FirstVC -> present SecondVC
                return .startSecondState
            }
            //FIXME: <-- END
            
            
        case .questionSecondAnswered(kanji: let kanji, correct: let correct):
            print("=2 isRight:",correct,"|", kanji.english) //save db
            currentIndex += 1
            if currentIndex < kanjiArray.count {
                updateSecondCard()
                return .startSecondState
            }
            else {
                currentIndex = 0
                //present third card
                presentFinishCard()
                return .startThirdState
            }
            
        case .questionThirdAnswered(word: let word, correct: let correct):
            print("=3 isRight:",correct,"|", word.english) //save db
            currentIndex += 1
            if currentIndex < wordsArray.count {
                //present third card
                return .startThirdState
            }
            else {
                currentIndex = 0
                //present forth card
                return .startForthState
            }
            
        case .questionForthAnswered(word: let word, correct: let correct):
            print("=4 isRight:",correct,"|", word.english) //save db
            currentIndex += 1
            if currentIndex < wordsArray.count {
                //present forth card
                return .startForthState
            }
            else {
                currentIndex = 0
                //present fifth card
                presentSecondCardAndDissmissPrevious()
                return .startFifthState
            }
            
        case .questionFifthAnswered(word: let word, correct: let correct):
            print("=5 isRight:",correct,"|", word.english) //save db
            currentIndex += 1
            if currentIndex < wordsArray.count {
                //present fifth card
                return .startFifthState
            }
            else {
                currentIndex = 0
                //present finish card
                return .startFinalAllResultState
            }
            
        case .onDissapear:
            DispatchQueue.main.async {
                self.currentVC?.dismiss(animated: false)
                DispatchQueue.main.async {
                    self.dismiss(animated: false)
                }
            }
            return .noQuestionsLeft
        case .error(_):
            return .error("someErr")
        }
    }
}
