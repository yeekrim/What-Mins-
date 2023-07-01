//
//  SpeechSynthesizer.swift
//  TimeSpeaker
//
//  Created by 길지훈 on 2023/06/01.
//

import AVFoundation

class SpeechSynthesizer {
    private let synthesizer: AVSpeechSynthesizer

    init() {
        self.synthesizer = AVSpeechSynthesizer()
    }

    func speak(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "ko-KR")
        utterance.rate = 0.4

        synthesizer.speak(utterance)
    }

    func stopSpeaking() {
        synthesizer.stopSpeaking(at: .immediate)
    }
}
