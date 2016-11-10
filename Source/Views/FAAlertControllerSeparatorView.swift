//
//  FAAlertControllerSeperatorView.swift
//  FAPlacemarkPicker
//
//  Created by Jesse Cox on 8/20/16.
//  Copyright © 2016 Apprhythmia LLC. All rights reserved.
//

import UIKit

class Blah: HighlightView {

}

@IBDesignable
class FAAlertControllerSeparatorView: UIView {
    
    var color: UIColor {
        switch  FAAlertControllerAppearanceManager.sharedInstance.appearanceStyle {
        case .default:
            return UIColor(white: 0.25, alpha: 1.0)
        case .dark:
            return .lightGray
        }
    }
    
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        translatesAutoresizingMaskIntoConstraints = false
        
        let vibrancyEffect = UIVibrancyEffect(blurEffect: FAAlertControllerAppearanceManager.sharedInstance.blurEffect)
        let vibrancyEffectView = UIVisualEffectView(effect: vibrancyEffect)
        vibrancyEffectView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(vibrancyEffectView)
        
        vibrancyEffectView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        vibrancyEffectView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        vibrancyEffectView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        vibrancyEffectView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        vibrancyEffectView.contentView.addSubview(viewWithColor(FAAlertControllerAppearanceManager.sharedInstance.separatorPrimaryColor))
        vibrancyEffectView.contentView.addSubview(viewWithColor(FAAlertControllerAppearanceManager.sharedInstance.separatorSecondaryColor))
        
        for view in vibrancyEffectView.contentView.subviews {
            view.widthAnchor.constraint(equalTo: vibrancyEffectView.widthAnchor).isActive = true
            view.heightAnchor.constraint(equalTo: vibrancyEffectView.heightAnchor).isActive = true
            view.centerXAnchor.constraint(equalTo: vibrancyEffectView.centerXAnchor).isActive = true
            view.centerYAnchor.constraint(equalTo: vibrancyEffectView.centerYAnchor).isActive = true
            view.alpha = 0.27
        }
        
        layoutIfNeeded()
        
        
    }
    
    func viewWithColor(_ color: UIColor) -> UIView {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = color
        return view
    }
    
}


@IBDesignable
class FAAlertControllerVerticalSeparatorView: FAAlertControllerSeparatorView {
    
    var heightConstraint: NSLayoutConstraint? {
        if superview != nil {
            return heightAnchor.constraint(equalTo: superview!.heightAnchor)
        } else {
            return nil
        }
    }
    
    override func commonInit() {
        super.commonInit()
        widthAnchor.constraint(equalToConstant: 0.5).isActive = true
        setContentHuggingPriority(1000, for: .horizontal)
    }
    
    override func didMoveToSuperview() {
        heightConstraint?.isActive = true
    }
    
    override func removeFromSuperview() {
        heightConstraint?.isActive = false
        super.removeFromSuperview()
    }
    
}


@IBDesignable
class FAAlertControllerHorizontalSeparatorView: FAAlertControllerSeparatorView {
    
    var widthConstraint: NSLayoutConstraint? {
        if superview != nil {
            return widthAnchor.constraint(equalTo: superview!.widthAnchor)
        } else {
            return nil
        }
    }
    
    override func commonInit() {
        super.commonInit()
        let heightConstraint = heightAnchor.constraint(equalToConstant: 0.5)
        heightConstraint.priority = 999
        heightConstraint.isActive = true
        setContentHuggingPriority(1000, for: .vertical)
    }
    
    override func didMoveToSuperview() {
        widthConstraint?.isActive = true
    }
    
    override func removeFromSuperview() {
        widthConstraint?.isActive = false
        super.removeFromSuperview()
    }
    
}

