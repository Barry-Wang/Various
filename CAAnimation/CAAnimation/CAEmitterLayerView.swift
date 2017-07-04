//
//  CAEmitterLayerView.swift
//  CAAnimation
//
//  Created by WangWei on 19/6/17.
//  Copyright © 2017 WangWei. All rights reserved.
//

import UIKit

class CAEmitterLayerView: UIView {
    
    
    var emitter:CAEmitterLayer!
    var backGroundImageView:UIImageView!
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.backgroundColor = UIColor.green
        
        let imageView = UIImageView(image:UIImage(named:"rain-back.png"))
        self.backGroundImageView = imageView;
        imageView.frame = self.bounds
        self.addSubview(imageView)
        
        
        self.emitter = CAEmitterLayer()
        self.layer .addSublayer(self.emitter)
            
        self.emitter.frame = CGRect(x:0, y:-20, width:self.bounds.size.width, height:self.bounds.size.height + 20);
        self.clipsToBounds = true
        
        
        
        
    }
    
    
    override class var layerClass: AnyClass {
        
        get {
            
            return CAEmitterLayer.self
        }
    }
    
    
    
    func show(type:Int) {
        
        if type == 1 {
            rain()
        } else if type == 2 {
           
            cloudy()
        } else if type == 3 {
            
            sunlight()
        }
        
    }
    
    
    func cloudy() {
       
        self.backGroundImageView.image = UIImage(named:"cloudy_back.png")
        let yun = UIImageView(image:UIImage(named:"yun.png"))
        yun.frame = CGRect(x:0,y:0, width:169, height:52)
        
        let yun_r = UIImageView(image:UIImage(named:"yun.png"))
        yun_r.frame = CGRect(x:self.frame.size.width - 169,y:30, width:169, height:52)


        
        let yunAnimation = CABasicAnimation(keyPath:"position.x")
        yunAnimation.fromValue = NSNumber(value:0.0 + 85)
        yunAnimation.toValue = NSNumber(value:Float(self.bounds.size.width - 85))
        yunAnimation.repeatCount = Float(Int8.max);
        yunAnimation.duration =  20.0
        
        yunAnimation.isRemovedOnCompletion = false;
        yunAnimation.fillMode = kCAFillModeForwards;
        yunAnimation.autoreverses = true
        
       yun.layer.add(yunAnimation, forKey: "yun")
        
        
        
        let yunAnimation_r = CABasicAnimation(keyPath:"position.x")
        yunAnimation_r.toValue = NSNumber(value:0.0 + 85)
        yunAnimation_r.fromValue = NSNumber(value:Float(self.bounds.size.width - 85))
        yunAnimation_r.repeatCount = Float(Int8.max);
        yunAnimation_r.duration =  25.0
        
        yunAnimation_r.isRemovedOnCompletion = false;
        yunAnimation_r.fillMode = kCAFillModeForwards;
        yunAnimation_r.autoreverses = true
        
        yun.layer.add(yunAnimation, forKey: "yun")
        yun_r.layer.add(yunAnimation_r, forKey: "yun_r")
        
        self .addSubview(yun)
        self.addSubview(yun_r)
        
    }
    
    
    
    func rain()  {
        
        self.backGroundImageView.image = UIImage(named:"rain_back.png")
        self.emitter.masksToBounds = true
        self.emitter.emitterShape = kCAEmitterLayerLine
        self.emitter.emitterMode = kCAEmitterLayerSurface
        self.emitter.emitterSize = self.bounds.size
        self.emitter.emitterPosition = CGPoint(x:self.frame.size.width / 2.0, y:-20)
        self.emitter.renderMode = kCAEmitterLayerAdditive
        
        let emitterCell = CAEmitterCell()
        emitterCell.contents = createRainImage()?.cgImage //UIImage(named: "rain.png")?.cgImage
        emitterCell.birthRate = 200  //每秒产生120个粒子
        emitterCell.lifetime = 3.0    //存活1秒
        emitterCell.lifetimeRange = 7.0
        
        emitterCell.yAcceleration = 70.0  //给Y方向一个加速度
        emitterCell.xAcceleration = -10.0 //x方向一个加速度
        
        emitterCell.velocity = 10.0 //初始速度
        emitterCell.velocityRange = 10.0
        
        emitterCell.emissionLongitude = CGFloat(Double.pi) //向左
        emitterCell.emissionRange = CGFloat(Double.pi / 2) //随机方向 -pi/2 --- pi/2
        
        
        emitterCell.scale = 0.8
        emitterCell.scaleRange = 0.3 //0 - 1.6
        emitterCell.scaleSpeed = -0.15  //逐渐变小
        
        
        emitterCell.alphaRange = 0.35   //随机透明度
        emitterCell.alphaSpeed = -0.15  //逐渐消失
        
        emitter.emitterCells = [emitterCell]  //这里可以设置多种粒子 我们以一种为粒子
        
    }
    
    func sunlight() {
        
        self.backGroundImageView.image = UIImage(named:"sunlight_back")
        

    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createImage(color:UIColor)->UIImage? {
        
        UIGraphicsBeginImageContext(CGSize(width:50, height:50))
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.setStrokeColor(color.cgColor)
        context?.strokeEllipse(in: CGRect(x:0,y:0,width:50, height:50))
        context?.fillEllipse(in: CGRect(x:0,y:0,width:50, height:50))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func createRainImage()->UIImage? {
        
        UIGraphicsBeginImageContext(CGSize(width:2, height:16))
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(UIColor.white.cgColor)
        context?.fill(CGRect(x:0,y:0,width:2, height:16))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
