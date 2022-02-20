//
//  QuizModel.swift
//  JQuiz
//
//  Created by Victor  on 18.02.2022.
//

import Foundation

enum QuizViewModelState {
    case start
    case startFirstState
    case startSecondState
    case startThirdState
    case startForthState
    case startFifthState
    case startFinalAllResultState
    case dotState
    case noQuestionsLeft
    case quizAnswerSended
    case error(_ errorMessage:String)
}

enum QuizViewModelEvent {
    case onAppear
    case questionFirstAnswered(word: WordModel ,correct: Bool)
    case questionSecondAnswered(kanji: KanjiModel ,correct: Bool)
    case questionThirdAnswered(word: WordModel ,correct: Bool)
    case questionForthAnswered(word: WordModel ,correct: Bool)
    case questionFifthAnswered(word: WordModel ,correct: Bool)
    case onDissapear
    case error(_ errorMessage: String)
}




