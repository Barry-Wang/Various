//
//  ViewController.swift
//  Various-S
//
//  Created by WangWei on 14/6/17.
//
//

import UIKit

class ViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let top = YMTopTab(frame:CGRect(x:0, y:20, width:100, height:100))
        self.view .addSubview(top)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}



