//
//  Voice.swift
//  JQuiz
//
//  Created by Victor  on 19.02.2022.
//

import Speech

func say(lang:String, text:String) {
    let audioSession = AVAudioSession.sharedInstance()
    do {
        try audioSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
    } catch let error as NSError {
        print("audioSession error: \(error.localizedDescription)")
    }
    
    let speechVoicesArray = AVSpeechSynthesisVoice.speechVoices()
    let speechVoice = speechVoicesArray.last { $0.language.contains(lang) }
    guard speechVoice != nil else { print("no voice"); return }
    
    let utterance = AVSpeechUtterance(string: text)
    utterance.voice = AVSpeechSynthesisVoice(identifier: speechVoice!.identifier)
    //     utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
    utterance.rate = 0.4 // 0.5 // speed normal
    //  utterance.pitchMultiplier = 1.0
    let synth = AVSpeechSynthesizer()
    if !synth.isSpeaking {
        synth.speak(utterance)
    }
}


