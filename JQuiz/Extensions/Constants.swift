//
//  Constants.swift
//  JQuiz
//
//  Created by Victor  on 18.02.2022.
//

import UIKit.UIColor
import UIKit

//FIXME: WHITE LABEL

let startQuizString = "START QUIZ"
let finishQuizString = "FINISH QUIZ"
let wayToGoString = "WAY TO GO 🎉"
var wordsTest: [WordModel] = [
    WordModel(lesson: "1", hiragana: "ついたち", kanji: "1日", english: "the first day of the month", russian: "первый день месяца", french: "premier jour du mois", chinese: "每月的第一天", type1: 1, type2: 1, date: Date()),
    WordModel(lesson: "1", hiragana: "ふつか", kanji: "2日", english: "the second, two days", russian: "второй, два дня", french: "le deuxième, deux jours", chinese: "第二，两天", type1: 1, type2: 1, date: Date()),
    WordModel(lesson: "1", hiragana: "みっか", kanji: "3日", english: "the third day, three days", russian: "третий день, три дня", french: "le troisième jour, trois jours", chinese: "第三天，三天", type1: 1, type2: 1, date: Date()),
    WordModel(lesson: "1", hiragana: "よっか", kanji: "4日", english: "fourth, four days", russian: "четвертый, четыре дня", french: "quatrième, quatre jours", chinese: "四、四天", type1: 1, type2: 1, date: Date()),
    WordModel(lesson: "1", hiragana: "いつか", kanji: "5日", english: "fifth, five days", russian: "пятый, пять дней", french: "cinquième, cinq jours", chinese: "五、五天", type1: 1, type2: 1, date: Date()),
]

var kanjiTest:[KanjiModel] = [
    KanjiModel(kanji: "雨", level: "1", desc: "あめ", english: "rain", russian: "дождь", french: "pluie", chinese: "雨", type1: 1, type2: 1,  date: Date()),
    KanjiModel(kanji: "友", level: "1", desc: "とも", english: "friend", russian: "друг", french: "ami", chinese: "朋友", type1: 1, type2: 1,  date: Date()),
    KanjiModel(kanji: "私", level: "1", desc: "わたし、わたくし", english: "me, mine, personal", russian: "я, свой, личный", french: "moi, le mien, personnel", chinese: "我，我的，个人的", type1: 1, type2: 1,  date: Date()),
    KanjiModel(kanji: "者", level: "1", desc: "者", english: "person, someone", russian: "человек, некто", french: "personne, quelqu'un", chinese: "人，某人", type1: 1, type2: 1,  date: Date()),
]
