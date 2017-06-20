//
//  ViewController.swift
//  CAAnimation
//
//  Created by WangWei on 19/6/17.
//  Copyright © 2017年 WangWei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        

        
        
        let emitterView = CAEmitterLayerView(frame:CGRect(x:0, y:60, width:self.view.frame.size.width, height:400))
        
        
        self.view .addSubview(emitterView)
        
        emitterView.show(type: 1)
        
        self.view.backgroundColor = UIColor.red
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

