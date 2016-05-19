//
//  ViewController.swift
//  Test-AAC-Record_Play
//
//  Created by b on 16/5/18.
//  Copyright © 2016年 b. All rights reserved.
//

import UIKit
import AudioBot

class ViewController: UIViewController {

    // 临时存放声音文件
    var voiceMemos: [VoiceMemo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var recordor: UIButton!
    
    @IBAction func play() {
        
        
        func tryPlay() {
            
            do {
                let progressPeriodicReport: AudioBot.PeriodicReport = (reportingFrequency: 10, report: { progress in
                    print("progress: \(progress)")
//
//                    voiceMemo.progress = CGFloat(progress)
//                    
//                    progressView.progress = progress
                })
                
//                let fromTime = NSTimeInterval(voiceMemo.progress) * voiceMemo.duration
                try AudioBot.startPlayAudioAtFileURL(voiceMemos[0].fileURL, fromTime: 0, withProgressPeriodicReport: progressPeriodicReport, finish: { success in
                    
                })
                
            } catch let error {
                print("play error: \(error)")
            }
        }
        
        if AudioBot.playing {
            AudioBot.pausePlay()
//            
//            if let strongSelf = self {
//                for index in 0..<(strongSelf.voiceMemos).count {
//                    let voiceMemo = strongSelf.voiceMemos[index]
//                    if AudioBot.playingFileURL == voiceMemo.fileURL {
//                        let indexPath = NSIndexPath(forRow: index, inSection: 0)
//                        if let cell = tableView.cellForRowAtIndexPath(indexPath) as? VoiceMemoCell {
//                            voiceMemo.playing = false
//                            cell.playing = false
//                        }
//                        
//                        break
//                    }
//                }
//            }
//            
//            if AudioBot.playingFileURL != voiceMemo.fileURL {
//                tryPlay()
//            }
            
        } else {
            tryPlay()
        }

        
    }
    
    
    @IBAction func record() {
        
        // 如果正在录制 停止
        // 如果未开始录制 则开始录制

        if AudioBot.recording {
            AudioBot.stopRecord { [weak self] fileURL, duration, decibelSamples in
                
                print("fileURL: \(fileURL)")
                print("duration: \(duration)")
                print("decibelSamples: \(decibelSamples)")
                
                
                
                let voiceMemo = VoiceMemo(fileURL: fileURL, duration: duration)
                self?.voiceMemos.append(voiceMemo)
                
            }
            
            
        } else {
            do {
                
                // 报告 分贝大小 分贝取样报告周期
                let decibelSamplePeriodicReport: AudioBot.PeriodicReport = (reportingFrequency: 10, report: { decibelSample in
                    print("decibelSample: \(decibelSample)")
                })
                
                // 关闭正在播放的其它外放
                AudioBot.mixWithOthersWhenRecording = false
                
                // 录制到文件中 会自动创建文件
                try AudioBot.startRecordAudioToFileURL(nil, forUsage: .Normal, withDecibelSamplePeriodicReport: decibelSamplePeriodicReport)
                
            } catch let error {
                print("record error: \(error)")
            }
        }

        
        
        
//        
//        
//        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
//        
//        let currentDateTime = NSDate()
//        let formatter = NSDateFormatter()
//        formatter.dateFormat = "ddMMyyyy-HHmmss"
//        let str_Recordedname = formatter.stringFromDate(currentDateTime)+".AAC"
//        
//        let pathArray = [dirPath, str_Recordedname]
//        
//        let filePath = NSURL.fileURLWithPathComponents(pathArray)
//        
//        print(filePath)
//        
//        
//        let settings = [
//            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
//            AVSampleRateKey: 44100.0,
//            AVNumberOfChannelsKey: 2 as NSNumber,
//            AVEncoderAudioQualityKey: AVAudioQuality.High.rawValue
//        ]
//        
//        
//        var recorder:AVAudioRecorder?
//        do {
//            try  recorder = AVAudioRecorder(URL: filePath!, settings: settings)
//            recorder!.prepareToRecord()
//
//        } catch let error as NSError{
//            print(error.description)
//        }
//        
//        
//        
//        let session = AVAudioSession.sharedInstance()
//
//        do{
//            try session.setCategory(AVAudioSessionCategoryRecord)
//            try session.setActive(true)
//        } catch let error as NSError{
//            print(error.description)
//        }
//        
//        
////        file:///Users/b/Library/Developer/CoreSimulator/Devices/664ED15B-5854-4F4B-A369-C30E9F2E1F83/data/Containers/Data/Application/35E589DA-6E1F-467E-B7A2-9B8330930962/Documents/18052016-161630.AAC
//        
//        
//        recorder!.record()
        
    }

    @IBAction func stopRecord() {
        
        
        
    }
    
    
    
    func x() {
    }
    
    
//
//    func record() {
//        self.prepareToRecord()
//        if let recorder = self.audioRecorder {
//            recorder.record()
//        }
//    }
//    
//    
//    func prepareToRecord() {
//
//        
//        
//        do
//        {
//            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord)
//            
//            self.audioRecorder = try AVAudioRecorder(URL:filePath!, settings:[:])
//            self.audioRecorder!.meteringEnabled = true
//            self.audioRecorder!.prepareToRecord()
//            self.audioRecorder!.record()
//            self.audioRecorder!.delegate = self
//            
//            
//            print("Recorded Audio is",filePath!)
//        }
//        catch let error as NSError
//        {
//            print(error.description)
//        }
    
//    }
}

