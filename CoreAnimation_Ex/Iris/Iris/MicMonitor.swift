//
//  MicMonitor.swift
//  Siri
//
//  Created by Marin Todorov on 6/23/15.
//  Copyright (c) 2015 Underplot ltd. All rights reserved.
//

import Foundation
import AVFoundation

class MicMonitor: NSObject {
    
    fileprivate var recorder: AVAudioRecorder!
    fileprivate var timer: Timer?
    fileprivate var levelsHandler: ((Float)->Void)?
    
    override init() {
        
        let url = URL(fileURLWithPath: "/dev/null", isDirectory: true)
        let settings: [String: AnyObject] = [
            AVSampleRateKey: 44100.0 as AnyObject,
            AVNumberOfChannelsKey: 1 as AnyObject,
            AVFormatIDKey: NSNumber(value: kAudioFormatAppleLossless as UInt32),
            AVEncoderAudioQualityKey: AVAudioQuality.min.rawValue as AnyObject
        ]
        
        let audioSession = AVAudioSession.sharedInstance()
        
        if audioSession.recordPermission() != .granted {
            audioSession.requestRecordPermission({success in print("microphone permission: \(success)")})
        }
        
        do {
            try recorder = AVAudioRecorder(url: url, settings: settings)
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
        } catch {
            print("Couldn't initialize the mic input")
        }
        
        if let recorder = recorder {
            //start observing mic levels
            recorder.prepareToRecord()
            recorder.isMeteringEnabled = true
        }
    }
    
    func startMonitoringWithHandler(_ handler: @escaping (Float)->Void) {
        levelsHandler = handler
        
        //start meters
        timer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(MicMonitor.handleMicLevel(_:)), userInfo: nil, repeats: true)
        recorder.record()
    }
    
    func stopMonitoring() {
        levelsHandler = nil
        timer?.invalidate()
        recorder.stop()
    }
    
    func handleMicLevel(_ timer: Timer) {
        recorder.updateMeters()
        levelsHandler?(recorder.averagePower(forChannel: 0))
    }
    
    deinit {
        stopMonitoring()
    }
    
}
