//
//  ParameterViewModel.swift
//  Whistle Timer
//
//  Created by Cam Way on 2022-09-20.
//

import Foundation
import AVFoundation

let whistleSoundPath = Bundle.main.path(forResource: "Whistle", ofType: "wav")
let url = URL(fileURLWithPath: whistleSoundPath ?? "")
var audioPlayer: AVAudioPlayer?

class ParameterViewModel: ObservableObject {
    @Published var shortestTime = 5.0
    @Published var longestTime = 10.0
    @Published var isRunning = false
    @Published var faceOffTime = 5
    
    
    func setRandomTime() {
        self.faceOffTime = Int.random(in: Int(self.shortestTime)...Int(self.longestTime))
    }
    
    func playWhistle() {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch let error {
            print(error)
        }
    }
}
