//
//  KanjiModel.swift
//  JQuiz
//
//  Created by Victor  on 18.02.2022.
//

import Foundation

struct KanjiModel: Codable, Equatable {
  var kanji, level, desc,english,russian,french,chinese : String
    var type1: Int?
    var type2: Int?
    var type3: Int?
    var type4: Int?
    var type5: Int?
    var date: Date?
}
