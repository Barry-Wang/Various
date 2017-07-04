//
//  CAEmitterLayerView.swift
//  CAAnimation
//
//  Created by WangWei on 19/6/17.
//  Copyright © 2017 WangWei. All rights reserved.
//

import UIKit

class CASunlightview: UIView {
    
    
    var emitter:CAEmitterLayer!
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.emitter = CAEmitterLayer()
        self.layer .addSublayer(self.emitter)
        
        self.emitter.frame = CGRect(x:0, y:0, width:self.bounds.size.width, height:self.bounds.size.height);
        self.clipsToBounds = true
        self.setup()
        
    }
    
    
    override class var layerClass: AnyClass {
        
        get {
            
            return CAEmitterLayer.self
        }
    }
    
    
    func  setup() {
        
        self.emitter.masksToBounds = true
        self.emitter.emitterShape = kCAEmitterLayerCircle
        self.emitter.emitterMode = kCAEmitterLayerSurface
        self.emitter.emitterSize = CGSize(width:0, height:100)
        self.emitter.emitterPosition = CGPoint(x:self.frame.size.width / 2, y:self.frame.size.height / 2);
        self.emitter.renderMode = kCAEmitterLayerAdditive;
    }
    
    
    func show(type:Int) {
        
        let sun = CAEmitterCell();
        sun.contents = UIImage(named:"fire")?.cgImage;
        sun.birthRate = 800;
        sun.lifetime = 1.0;
        sun.alphaSpeed = -0.4;
        sun.velocity = 50;
        sun.velocityRange = 10;
        sun.emissionRange = CGFloat(Double.pi);
        
        emitter.emitterCells = [sun]  //这里可以设置多种粒子 我们以一种为粒子
        
        
    }
    
    

    

    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
