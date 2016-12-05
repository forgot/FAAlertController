//
//  FAAlertTransition.swift
//  FAAlertController
//
//  Created by Jesse Cox on 7/7/16.
//  Copyright © 2016 Apprhythmia LLC. All rights reserved.
//

import UIKit

enum FAAlertTransitionMode: Int {
    case present = 0, dismiss
}

class FAAlertTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    static let presentDuration: TimeInterval = 0.2
    static let dismissDuration: TimeInterval = 0.25
    
    var mode: FAAlertTransitionMode = .present
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return mode == .present ? FAAlertTransition.presentDuration : FAAlertTransition.dismissDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let fromVC = transitionContext.viewController(forKey: .from), let toVC = transitionContext.viewController(forKey: .to) else {
            preconditionFailure("Could not obtain a view controller for the key `from` or `to`.")
        }
        
        let container = transitionContext.containerView
        let style = FAAlertControllerAppearanceManager.sharedInstance.preferredStyle
        
        if mode == .present {
            
            if let toVC = toVC as? FAAlertController, let view = toVC.view {
                
                container.addSubview(view)
                view.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
                
                if style == .alert {
                    
                    // 1) Setup the view as it will appear when the transition is complete
                    let layoutView = toVC.textFields?.isEmpty == false ? container.subviews[1] : container
                    view.centerYAnchor.constraint(equalTo: layoutView.centerYAnchor).isActive = true
                    if toVC.traitCollection.verticalSizeClass == .regular {
                        view.topAnchor.constraint(greaterThanOrEqualTo: layoutView.topAnchor, constant: 10).isActive = true
                        view.bottomAnchor.constraint(lessThanOrEqualTo: layoutView.bottomAnchor, constant: -10).isActive = true
                    } else if toVC.traitCollection.verticalSizeClass == .compact {
                        view.topAnchor.constraint(greaterThanOrEqualTo: layoutView.topAnchor, constant: 0).isActive = true
                        view.bottomAnchor.constraint(lessThanOrEqualTo: layoutView.bottomAnchor, constant: 0).isActive = true
                    }
                    container.layoutIfNeeded()
                    
                    // 2) Scroll to the preferred action
                    scrollToPreferredActionIfNeeded(using: transitionContext)
                    
                    // 3) Adjust the view to it's pre-animation position
                    view.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
                    view.alpha = 0.0
                    
                    // 4) Animate the view onto the screen
                    let option = UIViewAnimationOptions(rawValue: 7<<16)
                    UIView.animate(withDuration: 0.2, delay: 0.0, options: [option], animations: {
                        view.alpha = 1.0
                        if toVC.textFields?.isEmpty == false {
                            toVC.textFields!.first!.becomeFirstResponder()
                        }
                        self.scrollToPreferredActionIfNeeded(using: transitionContext)
                        view.transform = CGAffineTransform.identity
                        }, completion: { (finished) in
                            transitionContext.completeTransition(true)
                    })
                    
                } else if style == .actionSheet {
                    
                    // 1) Setup the view as it will appear when the transition is complete
                    let topConstraint = view.topAnchor.constraint(greaterThanOrEqualTo: container.topAnchor, constant: 10)
                    let bottomConstraint = view.bottomAnchor.constraint(lessThanOrEqualTo: container.bottomAnchor, constant: -10)
                    let actionSheetBottomConstraint = view.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10)
                    topConstraint.isActive = true
                    bottomConstraint.isActive = true
                    actionSheetBottomConstraint.isActive = true
                    container.layoutIfNeeded()
                    
                    // 2) Scroll to the preferred action
                    scrollToPreferredActionIfNeeded(using: transitionContext)
                    fromVC.view.tintAdjustmentMode = .dimmed
                    
                    // 3) Adjust the view to it's offscreen position
                    let _offscreenRect = CGRect(x: view.frame.minX, y: container.frame.maxY, width: view.frame.width, height: view.frame.height)
                    let _tempHeightConstraint = view.heightAnchor.constraint(equalToConstant: view.frame.height)
                    _tempHeightConstraint.isActive = true
                    topConstraint.isActive = false
                    bottomConstraint.isActive = false
                    actionSheetBottomConstraint.isActive = false
                    container.layoutIfNeeded()
                    view.frame = _offscreenRect
                    
                    // 4) Animate the view onto the screen
                    topConstraint.isActive = true
                    bottomConstraint.isActive = true
                    actionSheetBottomConstraint.isActive = true
                    UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: [.curveEaseOut], animations: {
                        container.layoutIfNeeded()
                        }, completion: { (finished) in
                            _tempHeightConstraint.isActive = false
                            transitionContext.completeTransition(true)
                    })
                    
                } else if style == .picker {
                    
                    // 1) Setup the view as it will appear when the transition is complete
                    let layoutView = container
                    view.centerYAnchor.constraint(equalTo: layoutView.centerYAnchor).isActive = true
                    if toVC.traitCollection.verticalSizeClass == .regular {
                        view.topAnchor.constraint(greaterThanOrEqualTo: layoutView.topAnchor, constant: 10).isActive = true
                        view.bottomAnchor.constraint(lessThanOrEqualTo: layoutView.bottomAnchor, constant: -10).isActive = true
                    } else if toVC.traitCollection.verticalSizeClass == .compact {
                        view.topAnchor.constraint(greaterThanOrEqualTo: layoutView.topAnchor, constant: 0).isActive = true
                        view.bottomAnchor.constraint(lessThanOrEqualTo: layoutView.bottomAnchor, constant: 0).isActive = true
                    }
                    container.layoutIfNeeded()
                    
                    // 2) Scroll to the preferred action
                    scrollToPreferredActionIfNeeded(using: transitionContext)
                    
                    // 3) Adjust the view to it's pre-animation position
                    view.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
                    view.alpha = 0.0
                    
                    // 4) Animate the view onto the screen
                    let option = UIViewAnimationOptions(rawValue: 7<<16)
                    UIView.animate(withDuration: 0.2, delay: 0.0, options: [option], animations: {
                        view.alpha = 1.0
                        self.scrollToPreferredActionIfNeeded(using: transitionContext)
                        view.transform = CGAffineTransform.identity
                    }, completion: { (finished) in
                        transitionContext.completeTransition(true)
                    })
                    
                }
            }
        } else if mode == .dismiss {
            if let fromVC = fromVC as? FAAlertController, let view = fromVC.view {
                if style == .alert {
                    
                    UIView.animate(withDuration: FAAlertTransition.dismissDuration, animations: {
                        view.alpha = 0.0
                        }, completion: { (finished) in
                            for view in container.subviews {
                                view.removeFromSuperview()
                            }
                            transitionContext.completeTransition(true)
                    })
                    
                } else if style == .actionSheet {
                    
                    let _currentRect = view.frame
                    let _offscreenRect = CGRect(x: view.frame.minX, y: container.frame.maxY, width: view.frame.width, height: view.frame.height)
                    var _constraints = [NSLayoutConstraint]()
                    
                    for constraint in container.constraints {
                        if constraint.firstItem as? UIView == view {
                            _constraints.append(constraint)
                        }
                    }
                    
                    for constraint in _constraints {
                        constraint.isActive = false
                    }
                    
                    container.layoutIfNeeded()
                    view.frame = _currentRect
                    
                    UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: [.curveEaseOut], animations: {
                        view.frame = _offscreenRect
                        }, completion: { (finished) in
                            transitionContext.completeTransition(true)
                    })
                    
                } else if style == .picker {
                    
                    UIView.animate(withDuration: FAAlertTransition.dismissDuration, animations: {
                        view.alpha = 0.0
                    }, completion: { (finished) in
                        for view in container.subviews {
                            view.removeFromSuperview()
                        }
                        transitionContext.completeTransition(true)
                    })
                    
                }
            }
        }
    }
    
    func scrollToPreferredActionIfNeeded(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toVC = transitionContext.viewController(forKey: .to) as? FAAlertController else {
            assertionFailure("Could not get the `to` view controller as FAAlertController.")
            return
        }
        if toVC.preferredAction != nil {
            if let actionsView = toVC.alertView?.actionsView, let actionViews = toVC.alertView?.actionsView?.stackView.arrangedSubviews {
                for view in actionViews {
                    if view is FAAlertActionView {
                        if (view as! FAAlertActionView).isPreferred {
                            var rect = (view as! FAAlertActionView).frame
                            let adjustment = (actionsView.frame.height - rect.height)/2
                            rect = CGRect(x: rect.origin.x, y: rect.origin.y - adjustment, width: rect.size.width, height: rect.size.height + (adjustment * 2))
                            toVC.alertView?.actionsView?.scrollRectToVisible(rect, animated: false)
                        }
                    }
                }
                toVC.alertView?.layoutIfNeeded()
            }
        }
    }
    
}
