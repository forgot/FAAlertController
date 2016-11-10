//
//  FAAlertActionView.swift
//  FAPlacemarkPicker
//
//  Created by Jesse Cox on 8/21/16.
//  Copyright © 2016 Apprhythmia LLC. All rights reserved.
//

import UIKit

class FAAlertActionView: UIView {
    
    var action: FAAlertAction
    var isPreferred = false
    var highlightView: UIView?
    let label = UILabel(frame: .zero)
    let alignmentView = UIView(frame: .zero)
    var shouldHandleTouchesCancelled = false
    var isHighlighted = false
    var previousView: UIView?
    var nextView: UIView?
    var _height: CGFloat {
        switch FAAlertControllerAppearanceManager.sharedInstance.preferredStyle {
        case .alert:
            return 44
        case .actionSheet:
            return 57
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: label.intrinsicContentSize.width, height: _height)
    }
    
    init(withAction action: FAAlertAction) {
        self.action = action
        super.init(frame: .zero)
        isPreferred = action.isPreferredAction
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        alignmentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(alignmentView)
        alignmentView.addSubview(label)
        label.adjustsFontSizeToFitWidth = true
        label.baselineAdjustment = .alignCenters
        label.textColor = FAAlertControllerAppearanceManager.sharedInstance.buttonTintColor
        
        alignmentView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        alignmentView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        alignmentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        alignmentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        alignmentView.leadingAnchor.constraint(equalTo: label.leadingAnchor).isActive = true
        alignmentView.trailingAnchor.constraint(equalTo: label.trailingAnchor).isActive = true
        label.topAnchor.constraint(equalTo: alignmentView.topAnchor, constant: 12).isActive = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        addGestureRecognizer(tap)
        let font: UIFont
        let preferredFont = UIFont.preferredFont(forTextStyle: UIFontTextStyle("UICTFontTextStyleShortHeadline"))
        let regularFont = UIFont.preferredFont(forTextStyle: UIFontTextStyle("UICTFontTextStyleShortBody"))
        
        switch action.style {
        case .default:
            switch  FAAlertControllerAppearanceManager.sharedInstance.preferredStyle {
            case .alert:
                font = isPreferred ? preferredFont : regularFont
            case.actionSheet:
                let _font = UIFont.preferredFont(forTextStyle: UIFontTextStyle("CTFontRegularUsage"))
                font = _font.withSize(20)
            }
        case .cancel:
            switch FAAlertControllerAppearanceManager.sharedInstance.preferredStyle {
            case .alert:
                font = isPreferred ? preferredFont : regularFont
            case .actionSheet:
                let _font = UIFont.preferredFont(forTextStyle: UIFontTextStyle("CTFontEmphasizedUsage"))
                font = _font.withSize(20)
            }
        case .destructive:
            switch FAAlertControllerAppearanceManager.sharedInstance.preferredStyle {
            case .alert:
                font = isPreferred ? preferredFont : regularFont
            case .actionSheet:
                let _font = UIFont.preferredFont(forTextStyle: UIFontTextStyle("CTFontRegularUsage"))
                font = _font.withSize(20)
            }
            label.textColor = UIColor(red: 1.0, green: 0.231, blue: 0.188, alpha: 1.0)
        }
        
        label.font = font
        label.minimumScaleFactor = 0.58
        label.text = action.title!
        label.textAlignment = .center
        label.sizeToFit()
        heightAnchor.constraint(equalToConstant: _height).isActive = true
        
    }
    
    func createHighlightView() -> UIView {
        let view = UIView(frame: bounds)
        switch FAAlertControllerAppearanceManager.sharedInstance.appearanceStyle {
        case .default:
            if FAAlertControllerAppearanceManager.sharedInstance.preferredStyle == .actionSheet && action.style == .cancel {
                let _view = UIView(frame: bounds)
                _view.backgroundColor = UIColor(white: 0.92156863, alpha: 1.0)
                view.addSubview(_view)
            } else {
                let mainBackdrop = FAAlertControllerAppearanceManager.sharedInstance.backdropView!
                let rect = self.convert(self.bounds, to: mainBackdrop)
                let image = UIImage.image(fromView: mainBackdrop, croppedToRect: rect)
                let highlightView = HighlightView(frame: bounds, image: image)
                view.addSubview(highlightView)
            }
        case .dark:
                let vibrancy = UIVibrancyEffect(blurEffect: FAAlertControllerAppearanceManager.sharedInstance.blurEffect)
                let effectView = UIVisualEffectView(effect: vibrancy)
                effectView.frame = view.bounds
                let subview = UIView(frame: view.bounds)
                subview.backgroundColor = .gray
                effectView.contentView.addSubview(subview)
                view.addSubview(effectView)
        }
        return view
    }
    
    func addHighlightView() {
        if highlightView == nil {
            highlightView = createHighlightView()
        } else if subviews.contains(highlightView!) {
            return
        }
        insertSubview(highlightView!, at: 0)
        isHighlighted = true
    }
    
    func removeHighlightView() {
        isHighlighted = false
        highlightView?.removeFromSuperview()
        highlightView = nil
        previousView?.alpha = 1.0
        nextView?.alpha = 1.0
    }
    
    func handleTap(sender: UITapGestureRecognizer) {
        removeHighlightView()
        action.performAction()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let point = touch.location(in: self)
            if bounds.contains(point) {
                addHighlightView()
                
                if let _superview = superview as? UIStackView {
                    if let index = _superview.arrangedSubviews.index(of: self) {
                        if index != _superview.arrangedSubviews.startIndex {
                            let previousIndex = _superview.arrangedSubviews.index(before: index)
                            previousView = _superview.arrangedSubviews[previousIndex]
                            previousView!.alpha = 0.0
                        }
                        if index != _superview.arrangedSubviews.endIndex - 1 {
                            let nextIndex = _superview.arrangedSubviews.index(after: index)
                            nextView = _superview.arrangedSubviews[nextIndex]
                            nextView!.alpha = 0.0
                        }
                        
                    }
                }
 
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let point = touch.location(in: self)
            if !bounds.contains(point) {
                removeHighlightView()
            } else {
                addHighlightView()
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let point = touch.location(in: self)
            if bounds.contains(point) {
                removeHighlightView()
                action.performAction()
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if shouldHandleTouchesCancelled {
            if let touch = touches.first {
                let point = touch.location(in: self)
                if bounds.contains(point) {
                    removeHighlightView()
                }
            }
        }
    }
    
}

