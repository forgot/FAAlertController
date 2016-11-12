//
//  FAAlertControllerBackdropView.swift
//  FAPlacemarkPicker
//
//  Created by Jesse Cox on 8/21/16.
//  Copyright © 2016 Apprhythmia LLC. All rights reserved.
//

import UIKit

class FAAlertControllerBackdropView: UIView {
    
    let backdrop = BlendableBackdropView(frame: .zero, target: nil, blendMode: FAAlertControllerAppearanceManager.sharedInstance.backdropBlendMode)
    let effectView = UIVisualEffectView(effect: FAAlertControllerAppearanceManager.sharedInstance.blurEffect)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        
        backdrop.translatesAutoresizingMaskIntoConstraints = false
        addSubview(backdrop)
        
        backdrop.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        backdrop.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        backdrop.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        backdrop.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        effectView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(effectView)
        
        effectView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        effectView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        effectView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        effectView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backdrop.setNeedsDisplay()
        FAAlertControllerAppearanceManager.sharedInstance.backdropView = self
    }
    
}


class BlendableBackdropView: BlendableView {
    
    var blendColor: UIColor = FAAlertControllerAppearanceManager.sharedInstance.backdropColor
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let context = UIGraphicsGetCurrentContext()!
        context.saveGState()
        let _rect = CGRect(x: 0, y: 0, width: rect.width, height: rect.height)
        
        // Draw and fill dimming path
        let dimmingPath = UIBezierPath(rect: _rect)
        let color = UIColor(white: 0, alpha: 0.4)
        color.setFill()
        dimmingPath.fill()
        
        context.setBlendMode(blendMode)
        
        // Draw and fill overlay path
        let overlayPath = UIBezierPath(rect: _rect)
        blendColor.setFill()
        overlayPath.fill()
        
        context.restoreGState()
    }
    
}
