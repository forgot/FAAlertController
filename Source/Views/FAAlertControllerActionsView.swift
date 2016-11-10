//
//  FAAlertControllerActionView.swift
//  FAPlacemarkPicker
//
//  Created by Jesse Cox on 8/21/16.
//  Copyright © 2016 Apprhythmia LLC. All rights reserved.
//

import UIKit


class FAAlertControllerActionsView: UIScrollView {
    
    var stackView = UIStackView(arrangedSubviews: [UIView]())
    var layoutView = UIView(frame: .zero)
    var minimumHeight: NSLayoutConstraint!
    var highlightPan: UIPanGestureRecognizer!
    
    var actions: [FAAlertAction]?
    var preferredAction: FAAlertAction?
    var cancelAction: FAAlertAction?
    
    var currentIndex: Int?
    
    var _maxWidth: CGFloat {
        return FAAlertControllerAppearanceManager.sharedInstance.maxWidth
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: _maxWidth, height: stackView.frame.height)
    }
    
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    
    convenience init() {
        self.init(frame: .zero)
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
        delaysContentTouches = false
        translatesAutoresizingMaskIntoConstraints = false
        layoutView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        addSubview(layoutView)
        layoutView.addSubview(stackView)
        
        widthAnchor.constraint(equalToConstant: _maxWidth).isActive = true
        minimumHeight = heightAnchor.constraint(greaterThanOrEqualToConstant: 44)
        minimumHeight.priority = 999
        minimumHeight.isActive = true
        layoutView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        layoutView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        layoutView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        
        stackView.topAnchor.constraint(equalTo: layoutView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: layoutView.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: layoutView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: layoutView.trailingAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: layoutView.centerXAnchor).isActive = true
        layoutView.heightAnchor.constraint(equalTo: stackView.heightAnchor).isActive = true
        
        highlightPan = UIPanGestureRecognizer(target: self, action: #selector(handleHighlightPan(sender:)))
        addGestureRecognizer(highlightPan)
    }
    
    /// Creates and configues the buttons using the FAAlertAction items, and adds them to a stack view for display
    func configureStackView() {
        if let _actions = actions {
            if !_actions.isEmpty {
                if stackView.arrangedSubviews.count != ((_actions.count * 2) - 1) {
                    switch FAAlertControllerAppearanceManager.sharedInstance.preferredStyle {
                    case .alert:
                        stackView.axis = _actions.count <= 2 ? .horizontal : .vertical
                    case .actionSheet:
                        stackView.axis = _actions.count <= 1 ? .horizontal : .vertical
                    }
                    for action in _actions {
                        let _view = FAAlertActionView(withAction: action)
                        stackView.addArrangedSubview(_view)
                        if (action == _actions.first) {
                            if stackView.axis == .horizontal {
                                _view.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
                                _view.topAnchor.constraint(equalTo: stackView.topAnchor).isActive = true
                            }
                        } else {
                            if let _first = stackView.arrangedSubviews.first {
                                _view.widthAnchor.constraint(equalTo: _first.widthAnchor).isActive = true
                            }
                        }
                        if (action == _actions.last) == false {
                            let separator = stackView.axis == .horizontal ? FAAlertControllerVerticalSeparatorView() : FAAlertControllerHorizontalSeparatorView()
                            stackView.addArrangedSubview(separator)
                        }
                    }
                }
            }
        }
    }
    
    func prepareForLayout() {
        configureStackView()
        if let _actions = actions {
            switch FAAlertControllerAppearanceManager.sharedInstance.preferredStyle {
            case .alert:
                minimumHeight.constant = _actions.count >= 3 ? 66 : 44
            case .actionSheet:
                minimumHeight.constant = _actions.count >= 2 ? 85.5 : 57
            }
        }
    }
    
    override func layoutSubviews() {
        
        invalidateIntrinsicContentSize()
        super.layoutSubviews()
        contentSize = CGSize(width: frame.width, height: layoutView.frame.height)
        
        if traitCollection.verticalSizeClass == .regular {
            delaysContentTouches = false
            if contentSize.height > frame.height {
                for view in stackView.arrangedSubviews {
                    if view is FAAlertActionView {
                        (view as! FAAlertActionView).shouldHandleTouchesCancelled = true
                    }
                }
                if highlightPan != nil {
                    highlightPan.isEnabled = false
                }
            } else {
                for view in stackView.arrangedSubviews {
                    if view is FAAlertActionView {
                        (view as! FAAlertActionView).shouldHandleTouchesCancelled = false
                    }
                }
                if highlightPan != nil {
                    highlightPan.isEnabled = true
                }
            }
        } else if traitCollection.verticalSizeClass == .compact {
            for view in stackView.arrangedSubviews {
                if view is FAAlertActionView {
                    (view as! FAAlertActionView).shouldHandleTouchesCancelled = true
                }
            }
            if highlightPan != nil {
                highlightPan.isEnabled = false
            }
        }
        
    }
    
    override func touchesShouldCancel(in view: UIView) -> Bool {
        if view is FAAlertActionView {
            return true
        }
        return super.touchesShouldCancel(in: view)
    }
    
    func handleHighlightPan(sender: UIPanGestureRecognizer) {
        
        switch sender.state {
        case .possible:
            break
        case .began:
            for view in stackView.arrangedSubviews {
                if view is FAAlertActionView {
                    let point = sender.location(in: view)
                    if view.bounds.contains(point) {
                        (view as! FAAlertActionView).addHighlightView()
                    } else {
                        (view as! FAAlertActionView).removeHighlightView()
                    }
                }
            }
        case .changed:
            for view in stackView.arrangedSubviews {
                if view is FAAlertActionView {
                    let point = sender.location(in: view)
                    if view.bounds.contains(point) {
                        (view as! FAAlertActionView).addHighlightView()
                    } else {
                        (view as! FAAlertActionView).removeHighlightView()
                    }
                }
            }
        case .ended:
            for view in stackView.arrangedSubviews {
                if view is FAAlertActionView {
                    let point = sender.location(in: view)
                    if view.bounds.contains(point) {
                        (view as! FAAlertActionView).action.performAction()
                    }
                    (view as! FAAlertActionView).removeHighlightView()
                }
            }
        case .cancelled:
            for view in stackView.arrangedSubviews {
                if view is FAAlertActionView {
                    (view as! FAAlertActionView).removeHighlightView()
                }
            }
        case .failed:
            for view in stackView.arrangedSubviews {
                if view is FAAlertActionView {
                    (view as! FAAlertActionView).removeHighlightView()
                }
            }
        }
        
        var previousIndex: Int?
        var nextIndex: Int?
        for view in stackView.arrangedSubviews {
            if let _view = view as? FAAlertActionView, _view.isHighlighted, let index = stackView.arrangedSubviews.index(of: _view) {
                if index != stackView.arrangedSubviews.startIndex {
                    previousIndex = index - 1
                }
                if index != stackView.arrangedSubviews.endIndex - 1 {
                    nextIndex = index + 1
                }
            }
        }
        for view in stackView.arrangedSubviews {
            if let index = stackView.arrangedSubviews.index(of: view) {
                if index != previousIndex && index != nextIndex {
                    view.alpha = 1.0
                } else {
                    view.alpha = 0.0
                }
            }
        }
        
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
        super.traitCollectionDidChange(previousTraitCollection)
        
        if traitCollection.verticalSizeClass == .regular {
            delaysContentTouches = false
            if contentSize.height > frame.height {
                for view in stackView.arrangedSubviews {
                    if view is FAAlertActionView {
                        (view as! FAAlertActionView).shouldHandleTouchesCancelled = true
                    }
                }
                if highlightPan != nil {
                    highlightPan.isEnabled = false
                }
            } else {
                for view in stackView.arrangedSubviews {
                    if view is FAAlertActionView {
                        (view as! FAAlertActionView).shouldHandleTouchesCancelled = false
                    }
                }
                if highlightPan != nil {
                    highlightPan.isEnabled = true
                }
            }
        } else if traitCollection.verticalSizeClass == .compact {
            if contentSize.height > frame.height {
                contentOffset = CGPoint(x: 0, y: 4)
            }
            for view in stackView.arrangedSubviews {
                if view is FAAlertActionView {
                    (view as! FAAlertActionView).shouldHandleTouchesCancelled = true
                    if (view as! FAAlertActionView).isPreferred {
                        let _frame = (view as! FAAlertActionView).frame
                        let rect = CGRect(x: _frame.origin.x, y: _frame.origin.y + _frame.height/4, width: _frame.width, height: _frame.height)
                        scrollRectToVisible(rect, animated: false)
                    }
                }
            }
            if highlightPan != nil {
                highlightPan.isEnabled = false
            }
        }
        
    }
    
    
}
