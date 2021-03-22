//
//  WatermelonLoadingView.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 04.02.2021.
//

import UIKit

final class WatermelonLoadingView: UIView {
    
    let staticWatermelon = CAShapeLayer()
    let layerAnimation = CAShapeLayer()
    
    func setup() {

        let watermelon = UIBezierPath()
        watermelon.move(to: CGPoint(x: 20, y: 10))
        watermelon.addLine(to: CGPoint(x: 100, y: 10))
        watermelon.addQuadCurve(to: CGPoint(x: 20, y: 10), controlPoint: CGPoint(x: 55, y: 70))
        watermelon.close()
        staticWatermelon.path = watermelon.cgPath
        staticWatermelon.fillColor = UIColor.red.cgColor
        self.layer.addSublayer(staticWatermelon)
        
        let shape = UIBezierPath()
        shape.move(to: CGPoint(x: 20, y: 10))
        shape.addQuadCurve(to: CGPoint(x: 100, y: 10), controlPoint: CGPoint(x: 55, y: 70))
        shape.addLine(to: CGPoint(x: 105, y: 10))
        shape.addQuadCurve(to: CGPoint(x: 15, y: 10), controlPoint: CGPoint(x: 55, y: 80))
        shape.close()
        
        layerAnimation.path = shape.cgPath
        layerAnimation.strokeColor = UIColor.systemGreen.cgColor
        layerAnimation.fillColor = UIColor.clear.cgColor
        layerAnimation.lineWidth = 3
        layerAnimation.lineCap = .round
        
        self.layer.addSublayer(layerAnimation)
        
        let strokeStartAnimation = CABasicAnimation(keyPath: "strokeStart")
        strokeStartAnimation.fromValue = 0
        strokeStartAnimation.toValue = 1

        let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeEndAnimation.fromValue = 0
        strokeEndAnimation.toValue = 1
        strokeStartAnimation.beginTime = 0.25

        let animationGroup = CAAnimationGroup()
        animationGroup.fillMode = CAMediaTimingFillMode.backwards
        animationGroup.duration = 2
        animationGroup.animations = [strokeStartAnimation, strokeEndAnimation]
        animationGroup.repeatCount = .infinity
        layerAnimation.add(animationGroup, forKey: nil)
        
    }
    
}
