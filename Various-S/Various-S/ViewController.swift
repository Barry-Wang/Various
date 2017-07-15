//
//  ViewController.swift
//  Various-S
//
//  Created by WangWei on 14/6/17.
//
//

import UIKit

class ViewController: UIViewController, OTTouchButtonDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let touchButton = OTTouchButton(frame:CGRect(x:30, y:100, width:150, height:150), title:"长按说话")
        self.view .addSubview(touchButton)
        touchButton.delegate = self
        
        
        
        let button = UIButton(type:.custom)
        button.setTitle("Play", for: .normal)
        button.frame = CGRect(x:30, y:240, width:100, height:50)
        button.backgroundColor = UIColor.red
        button.addTarget(self, action: #selector(ViewController.playAudio), for: .touchUpInside)
        self.view .addSubview(button)
        
    }
    
    func playAudio() {
        
        OTAudioSession.shareInstance.playAudion()
    }
    
    
    func touchBegin() -> Bool {
        
        if OTAudioSession.shareInstance.permit() == false {
          
            return false
        }
        
        OTAudioSession.shareInstance.record()
        
        return true
    }
    

    
    
    func touchEnd(isCancel:Bool) {
        
        OTAudioSession.shareInstance.stopRecord()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}



