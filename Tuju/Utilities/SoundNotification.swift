//
//  SoundNotification.swift
//  Tuju
//
//  Created by Eldwin Anthony on 08/11/22.
//

import Foundation
import AVFoundation
import AudioToolbox

let systemSoundID: SystemSoundID = 1016


func vibrateTwice(){
    AudioServicesPlaySystemSoundWithCompletion(kSystemSoundID_Vibrate) {
               AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
           }
}

func vibrateThreeTimes(){
    AudioServicesPlaySystemSoundWithCompletion(kSystemSoundID_Vibrate) {
        vibrateTwice()
    }
}


