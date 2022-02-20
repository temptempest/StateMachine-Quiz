//
//  String+Extension.swift
//  JQuiz
//
//  Created by Victor  on 18.02.2022.
//

import Foundation

func getStringFromWord(word:WordModel,lang:Lang) -> String {
    switch lang {
    case .english:
        return word.english
    case .russian:
        return word.russian
    case .french:
        return word.french
    case .chinese:
        return word.chinese
    }
}

func getStringFromKanji(kanji:KanjiModel,lang:Lang) -> String {
    switch lang {
    case .english:
        return kanji.english
    case .russian:
        return kanji.russian
    case .french:
        return kanji.french
    case .chinese:
        return kanji.chinese
    }
}
