//
//  YMButton.swift
//  Various-S
//
//  Created by WangWei on 15/6/17.
//
//

import UIKit

class YMButton: UIButton {


    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("YMButton touch begin");

        super.touchesBegan(touches, with: event);
    }
    

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        print("YMButton touch touchesCancelled cancelled");
        
    }

}
