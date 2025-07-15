//
//  RingView.swift
//  FitnessApp
//

import Foundation
import UIKit

protocol RingViewDelegate : AnyObject {
     func animationDidEnd()
}

class RingView: UIView {
    
    weak var delegate: RingViewDelegate?
    var action: (() -> Void)?
    
   let backdropLayer: CAShapeLayer    = CAShapeLayer()
   let ringLayer    : CAShapeLayer    = CAShapeLayer()
   let gradientLayer: CAGradientLayer = CAGradientLayer()
   
   let ringWidth: CGFloat = CGFloat(40.0)
   let offset   : CGFloat = CGFloat(90 * Double.pi / 180)
   
   var halfRingWidth: CGFloat {
       return ringWidth / 2
   }
   
   var circlePath: CGPath {
       return UIBezierPath(ovalIn: CGRect(
           x: halfRingWidth,
           y: halfRingWidth,
           width : bounds.width  - ringWidth,
           height: bounds.height - ringWidth)
       ).cgPath
   }
   
   var progress: CGFloat = CGFloat(0.5) {
       didSet {
                if progress >= 1.0 {
                   progress = 1.0
           }
           else if progress <= 0.0 {
                   progress = 0.0
           }
           
           ringLayer.strokeEnd = progress
       }
   }

   override func didMoveToSuperview() {
       super.didMoveToSuperview()
       
       drawBackDropLayer()
       drawRingLayer()
   }
   
   
   func drawBackDropLayer() {

       
       backdropLayer.path        = circlePath
       backdropLayer.lineWidth   = ringWidth
       backdropLayer.strokeEnd   = 1.0
       backdropLayer.fillColor   = nil
       backdropLayer.strokeColor = UIColor(red  : 112 / 255,
                                           green: 25  / 255,
                                           blue : 18  / 255,
                                           alpha: 1.0).cgColor
       
       layer.addSublayer(backdropLayer)
   }
   
   func drawRingLayer() {
       ringLayer.path        = circlePath
       ringLayer.frame       = CGRect(x: 0,
                                      y: 0,
                                      width: bounds.width,
                                      height: bounds.height)
       ringLayer.lineWidth   = ringWidth
       ringLayer.strokeColor = UIColor.black.cgColor
       ringLayer.fillColor   = nil
       ringLayer.strokeEnd   = 0.5
       ringLayer.lineCap     = .round
       ringLayer.transform   = CATransform3DMakeRotation(offset, 0, 0, -1.0)
       
       // layer.addSublayer(ringLayer)
       
       gradientLayer.colors    = [UIColor(red  : 231 / 255,
                                          green: 51  / 255,
                                          blue : 38  / 255,
                                          alpha: 1.0).cgColor,
                                  UIColor(red  : 248 / 255,
                                          green: 255 / 255,
                                          blue : 174 / 255,
                                          alpha: 1.0).cgColor]
       gradientLayer.frame     = bounds
       gradientLayer.locations = [0.0, 1.0]
       gradientLayer.mask      = ringLayer
       
       layer.addSublayer(gradientLayer)
   }
    
    func startAnimation(time:  Int) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        
        animation.duration              = CFTimeInterval(time)
        animation.repeatCount           = 1
        animation.isRemovedOnCompletion = false
        animation.fromValue             = 0
        animation.toValue               = 1
        animation.timingFunction        = CAMediaTimingFunction(name: .linear)
        
        ringLayer.add(animation, forKey: nil)
    }

}

extension RingView: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        delegate?.animationDidEnd()
    }
    
}

/*
 ⸻

 🔧 In RingView.swift – 3 Core Components:

 ① Define the Protocol RingViewDelegate

 protocol RingViewDelegate: AnyObject {
     func animationDidEnd()
 }

     •    This is a contract of obligation.
     •    AnyObject restricts the protocol to be adopted only by class types (to avoid retain cycles).

 ⸻

 ② Declare the Delegate Property

 weak var delegate: RingViewDelegate?

     •    This is RingView’s external contact point.
     •    weak is used to prevent memory leaks (avoiding strong reference cycles between RingView and the controller).

 ⸻

 ③ Notify the Delegate After Animation Ends

 extension RingView: CAAnimationDelegate {
     func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
         delegate?.animationDidEnd()
     }
 }

     •    This is a method from CAAnimationDelegate, triggered when the animation completes.
     •    delegate?.animationDidEnd() notifies the external controller.

 ⸻

 🎮 In WorkoutViewController.swift – 2 Core Components:

 ① Set the Delegate Object

 override func viewDidLoad() {
     super.viewDidLoad()
     ringView.delegate = self
 }

     •    Assigns the current controller (self) as the delegate of RingView.
     •    Without this line, RingView wouldn’t know who its delegate is and can’t trigger callbacks.

 ⸻

 ② Implement the Protocol Method

 extension WorkoutViewController: RingViewDelegate {
     func animationDidEnd() {
         print("animation ended. workoutvc is informed")
     }
 }

     •    The controller conforms to the RingViewDelegate protocol and becomes a valid delegate.
     •    When the animation ends, RingView will call this method.

 ⸻

 🧠 Delegate Pattern Analogy:
     •    Defining the protocol: Like a person studying hard to become a “diplomat” — they must master professional skills (i.e., method definitions).
     •    Declaring the delegate: The country gives the diplomat a “passport” to represent the nation abroad.
     •    Triggering the delegate callback: The diplomat carries the passport and travels to complete their mission (send notification).
     •    Setting the delegate object: At the border, the customs officer verifies the passport — confirming the diplomat is a legitimate envoy (controller sets itself as delegate).
     •    Implementing the protocol method: The diplomat is granted entry and begins official communications (controller responds to the callback).

 ⸻

 📌 One-Sentence Summary:

 A protocol defines the identity, the delegate is the communication channel, setting the delegate establishes the connection, and implementing the method completes the communication.
 
 */



/*
 ⸻

 🔧 在 RingView.swift 文件中 —— 共 3 个核心部分：

 ① 定义协议 RingViewDelegate

 protocol RingViewDelegate: AnyObject {
     func animationDidEnd()
 }

     •    这是一个 承诺规则（contract）。
     •    AnyObject 限定只能被 class 遵守（避免循环引用）。

 ⸻

 ② 声明代理属性

 weak var delegate: RingViewDelegate?

     •    这是 RingView 对外部的“联系人”。
     •    用 weak 是为了防止内存泄漏（防止 RingView 和 Controller 互相强引用）。

 ⸻

 ③ 动画结束后通知 delegate

 extension RingView: CAAnimationDelegate {
     func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
         delegate?.animationDidEnd()
     }
 }

     •    CAAnimationDelegate 的方法，在动画完成后触发。
     •    通过 delegate?.animationDidEnd() 通知外部控制器。

 ⸻

 🎮 在 WorkoutViewController.swift 文件中 —— 共 2 个核心部分：

 ① 设置代理对象

 override func viewDidLoad() {
     super.viewDidLoad()
     ringView.delegate = self
 }

     •    把当前的控制器 self 赋值为 RingView 的代理。
     •    没这行代码，RingView 不知道谁是它的代理，无法回调。

 ⸻

 ② 实现协议方法

 extension WorkoutViewController: RingViewDelegate {
     func animationDidEnd() {
         print("animation ended. workoutvc is informed")
     }
 }

     •    控制器实现了 RingViewDelegate 协议，成为“合法代理”。
     •    当动画结束时，RingView 会调用这个方法。

 ⸻
 
 可以这样类比理解 delegate 模式：
     •    定义协议   ：就像一个人努力学习，立志成为“外交官”，必须掌握一些专业本领（方法规范）。
     •    声明代理属性：国家给这位外交官发放“护照”，让他能代表国家出使他国。
     •    动画结束通知 delegate：外交官持护照出发，去执行任务（发出通知）。
     •    设置代理对象：目标国家的“边检官”检查护照，确认他是合法使者（控制器设置为代理）。
     •    实现协议方法：外交官顺利“入境”，开始和目标国家对话（控制器响应通知，处理后续逻辑）。

 ⸻

 📌 总结一句话：

 协议是身份规范，代理是通信渠道，设置代理是建立联系，实现方法是完成沟通。

 */

