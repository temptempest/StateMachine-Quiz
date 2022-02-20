//
//  WordsModel.swift
//  JQuiz
//
//  Created by Victor  on 18.02.2022.
//

import Foundation

enum Lang {
  case english
  case russian
  case french
  case chinese
}

struct WordModel: Codable, Equatable {
  var lesson, hiragana,kanji,english,russian,french,chinese : String
    var type1: Int?
    var type2: Int?
    var type3: Int?
    var type4: Int?
    var type5: Int?
    var date: Date?
}
