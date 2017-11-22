//
//  rotateArrowView.swift
//  worldRegions
//
//  Created by Usha Natarajan on 9/4/17.
//  Copyright © 2017 Usha Natarajan. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")//keyPath must be typed exactly as is for spinning action.
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        self.layer.add(animation, forKey: nil)
    }
}
