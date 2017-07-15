//
//  OTTouchButton.swift
//  Various-S
//
//  Created by WangWei on 12/7/17.
//
//

import UIKit

protocol OTTouchButtonDelegate {
    
    func touchBegin() -> Bool
    func touchEnd(isCancel:Bool)
}


class OTTouchButton: UIView {
    
    
    let shadow = UIView()
    let shadow2 = UIView()
    let imageView = UIImageView(image:UIImage(named:"speaker.png"))
    var movePoint = CGPoint(x:0, y:0)
    var isCancel:Bool = false
    var delegate:OTTouchButtonDelegate?
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }
    
    convenience init(frame:CGRect, title:String) {
        
        self.init(frame: frame)
        self.layer.cornerRadius = self.frame.size.width / 2
        
        shadow.backgroundColor = UIColor(red:19 / 255.0 , green: 151 / 255.0, blue: 135 / 255.0, alpha: 1.0)
        shadow.frame = self.bounds
        shadow.layer.cornerRadius = self.frame.size.width / 2
        shadow.alpha = 0;
        self.addSubview(shadow)
        
        
        shadow2.backgroundColor = UIColor(red:19 / 255.0 , green: 151 / 255.0, blue: 135 / 255.0, alpha: 1.0)
        shadow2.frame = self.bounds
        shadow2.layer.cornerRadius = self.frame.size.width / 2
        shadow2.alpha = 0;
        self.addSubview(shadow2)
        
        imageView.frame = CGRect(x:0, y:0, width:self.frame.size.width / 2, height:self.frame.size.height / 2)
        imageView.center = CGPoint(x:self.frame.size.width / 2, y:self.frame.size.height / 2)
        
        self.addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        let touch:UITouch  = (touches as NSSet).anyObject()! as! UITouch
        movePoint = touch.location(in: self)

        self.shadow.alpha = 0.6
        
        if (self.delegate?.touchBegin())! {
            
            self.shadow.layer.add(self.createAnimation(offset: 0), forKey: "move")
            self.shadow2.layer.add(self.createAnimation(offset: 0.3), forKey: "move")
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.shadow.alpha = 0.0
        self.shadow.layer.removeAllAnimations()
        self.shadow2.layer.removeAllAnimations()
        
        
        self.delegate?.touchEnd(isCancel:isCancel)


    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch:UITouch  = (touches as NSSet).anyObject()! as! UITouch
        
       let  currentPoint = touch.location(in: self)
        
        // 上移10个像素取消发送
        if currentPoint.y - movePoint.y < -10 {
            
            movePoint = CGPoint(x:0,y:-50)
            self.isCancel = true
        }
        
    }

    
    func createAnimation(offset:CFTimeInterval) -> CAAnimationGroup {
        
        
        let animation = CABasicAnimation(keyPath:"transform.scale")
        
        // 缩放倍数
        animation.fromValue = NSNumber(value:0.1) // 开始时的倍率
        animation.toValue = NSNumber(value:1.0); // 结束时的倍率
        
        
        let opAnimation = CABasicAnimation(keyPath:"opacity")
        
        opAnimation.fromValue = 0.6
        opAnimation.toValue = 0.0
        
        let animationGroup = CAAnimationGroup()
        animationGroup.timeOffset = offset
        animationGroup.duration = 1
        animationGroup.repeatCount = 100
        animationGroup.animations = [animation, opAnimation]
        
        // 添加动画  
       return animationGroup
    }
}
