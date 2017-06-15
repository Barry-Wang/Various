//
//  YMTableView.swift
//  Various-S
//
//  Created by WangWei on 14/6/17.
//
//

import UIKit

class YMTableView: UITableView {
    
    override func awakeFromNib() {
        
        self.delaysContentTouches = false
        self.canCancelContentTouches =  true
        
    }
}
