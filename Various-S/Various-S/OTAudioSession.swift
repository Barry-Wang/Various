

//
//  OTAudioSession.swift
//  Various-S
//
//  Created by WangWei on 12/7/17.
//
//

import UIKit
import AVFoundation

class OTAudioSession: NSObject {

    static let shareInstance = OTAudioSession()
    var recorderSeetingsDic:[String : Any]?
    
    let audionSession = AVAudioSession.sharedInstance()
    var audioPath:String?
    
    var recorder:AVAudioRecorder?
    var player:AVAudioPlayer?
    
    override init() {
        
        super.init()
        initAudioSession()
    }
    
    func initAudioSession()  {
        
        try! audionSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
        try! audionSession.setActive(true)
        
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        audioPath = docDir + "/play.caf"
        
   


        
        
        
        recorderSeetingsDic =
            [
                AVFormatIDKey: NSNumber(value: kAudioFormatAppleLossless),
                AVNumberOfChannelsKey: 2, //录音的声道数，立体声为双声道
                AVEncoderAudioQualityKey : AVAudioQuality.high.rawValue,
                AVEncoderBitRateKey : 320000,
                AVSampleRateKey : 44100.0, //录音器每秒采集的录音样本数
                AVLinearPCMBitDepthKey:16
                ]
    }
    
    func record() {
       

        do {
            
             try! audionSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
        recorder = try  AVAudioRecorder(url: URL(string: audioPath!)!,
                                        settings: recorderSeetingsDic!)
        }catch let error {
            
            print(error)
        }
        if (recorder != nil) {
           
            recorder!.isMeteringEnabled = true
            recorder!.prepareToRecord()
            recorder!.record()
            
        }
        
    }
    
    func stopRecord(){
        
        recorder?.stop()
        recorder = nil
        
    }
    
    func playAudion()  {
        
        do {
            
             try! audionSession.setCategory(AVAudioSessionCategoryPlayback)
           try! audionSession.setActive(true)
//
            player = try AVAudioPlayer(contentsOf: URL(string: audioPath!)!)

        } catch let error {
           
            print("播放失败了" + error.localizedDescription)
        }
        
        if player == nil {
            print("播放失败")
        }else{
            player?.play()
        }
    }
    
    func permit() -> Bool {
        
        if audionSession.recordPermission() == .denied {
            
            return false;
        }
        
        return true
        
    }
    
    
}
