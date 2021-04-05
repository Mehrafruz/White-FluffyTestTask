//
//  UIButton.swift
//  WhiteAndFluffyTestTask
//
//  Created by Мехрафруз on 02.04.2021.
//  Copyright © 2021 Мехрафруз. All rights reserved.
//

import UIKit

extension UIButton {
    func setupLittleButton(imageName: String, bgImageName: String, tintColor: UIColor) {
        self.setImage( UIImage(systemName: imageName), for: UIControl.State.normal)
        self.setBackgroundImage( UIImage(systemName: bgImageName), for: UIControl.State.normal)
        self.setTitleColor(UIColor.white, for: UIControl.State.normal)
        self.tintColor = tintColor
        self.layer.cornerRadius = 25
        self.clipsToBounds = true
        self.layer.shadowRadius = 3.0
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
    }
    
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.6
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 2
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        
        layer.add(pulse, forKey: "pulse")
    }
}



