//
//  FAAlertControllerInterfaceView.swift
//  FAAlertController
//
//  Created by Jesse Cox on 9/25/16.
//  Copyright © 2016 Apprhythmia LLC. All rights reserved.
//

import UIKit


class FAAlertControllerInterfaceView: UIView {

    var _maxWidth: CGFloat {
        return FAAlertControllerAppearanceManager.sharedInstance.maxWidth
    }
    var backdropView: FAAlertControllerBackdropView?
    var stack: UIStackView = UIStackView(arrangedSubviews: [UIView]())
    var title: String?
    var message: String?
    var radius: CGFloat  = 13
    var isBackdropViewHidden = false
    
    init(withBackdrop: Bool = true) {
        isBackdropViewHidden = !withBackdrop
        super.init(frame: .zero)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        clipsToBounds = true
        layer.cornerRadius = radius
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: _maxWidth).isActive = true
        
        if isBackdropViewHidden {
            let view = UIView(frame: bounds)
            view.backgroundColor = FAAlertControllerAppearanceManager.sharedInstance.actionSheetCancelBackdropColor
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
            view.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
            view.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
            view.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            view.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        } else {
            backdropView = FAAlertControllerBackdropView(frame: bounds)
            backdropView!.translatesAutoresizingMaskIntoConstraints = false
            addSubview(backdropView!)
            backdropView!.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
            backdropView!.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
            backdropView!.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            backdropView!.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        }
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        addSubview(stack)
        
        stack.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stack.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stack.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    func prepareForLayout() {
        setNeedsLayout()
    }
    
}
