//
//  FAAlertControllerPresentationController.swift
//  FAPlacemarkPicker
//
//  Created by Jesse Cox on 9/14/16.
//  Copyright © 2016 Apprhythmia LLC. All rights reserved.
//

import UIKit

class FAAlertControllerPresentationController: UIPresentationController {
    
    let dimmingView = UIView(frame: .zero)
    let layoutView = UIView(frame: .zero)
    let keyboardLayoutAlignmentView = UIView(frame: .zero)
    var keyboardLayoutAlignmentViewHeightConstraint: NSLayoutConstraint?
    var keyboardLayoutAlignmentViewHeightConstraintConstant: CGFloat = 0.0
    
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        dimmingView.backgroundColor = UIColor(white: 0, alpha: 0.4)
        dimmingView.alpha = 0.0
    }
    
    override func presentationTransitionWillBegin() {
        
        // Get critical information about the presentation.
        guard let containerView = self.containerView else {
            preconditionFailure("The container view was not found")
        }
        // Cast `self.presentedViewController` to FAAlertController
        let presentedViewController = self.presentedViewController as! FAAlertController
        // Set the target for the backdrop (so it knows which view to image from)
        (presentedView as! FAAlertControllerView).interfaceView.backdropView?.backdrop.target = presentingViewController.view
        
        // If there are no actions/cancelAction, enable tap-to-dismiss on the dimmingView
        if presentedViewController.actions.isEmpty || (presentedViewController.preferredStyle == .actionSheet && (presentedView as! FAAlertControllerView).cancelAction != nil) {
            let tap = UITapGestureRecognizer(target: presentedViewController, action: #selector(presentedViewController.dismiss(_:)))
            dimmingView.addGestureRecognizer(tap)
        }        
        
        // Set the dimming view to the size of the container's
        // bounds, and make it transparent initially.
        dimmingView.frame = containerView.bounds
        dimmingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        dimmingView.alpha = 0.0
        
        // Insert the dimming view below everything else.
        containerView.addSubview(dimmingView)
        
        // Configure the layout views, and add them to the containerView
        layoutView.translatesAutoresizingMaskIntoConstraints = false
        layoutView.isUserInteractionEnabled = false
        keyboardLayoutAlignmentView.translatesAutoresizingMaskIntoConstraints = false
        keyboardLayoutAlignmentView.isUserInteractionEnabled = false
        containerView.addSubview(layoutView)
        containerView.addSubview(keyboardLayoutAlignmentView)

        // Setup constraints
        // Layout View Constraints
        layoutView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        layoutView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        layoutView.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        layoutView.bottomAnchor.constraint(equalTo: keyboardLayoutAlignmentView.topAnchor).isActive = true
        // Keyboard Alignment View Constraints
        keyboardLayoutAlignmentView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        keyboardLayoutAlignmentView.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        keyboardLayoutAlignmentView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        keyboardLayoutAlignmentView.topAnchor.constraint(equalTo: layoutView.bottomAnchor).isActive = true
        keyboardLayoutAlignmentViewHeightConstraint = keyboardLayoutAlignmentView.heightAnchor.constraint(equalToConstant: keyboardLayoutAlignmentViewHeightConstraintConstant)
        keyboardLayoutAlignmentViewHeightConstraint!.isActive = true
        
        // Start listening for keyboard presentation/dismissal notifications
        NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard(notification:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard(notification:)), name: .UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(fixTextField(notification:)), name: .UITextFieldTextDidEndEditing, object: nil)
        
        // Insert the layout views above the dimming view
        containerView.layoutIfNeeded()
        
        // The view should now "appear" as it will after the transition
        
        if let coordinator = presentedViewController.transitionCoordinator {
            // Set up the animations for fading in the dimming view.
            coordinator.animate(alongsideTransition: { (context) in
                self.dimmingView.alpha = 1.0
                self.presentingViewController.view.tintAdjustmentMode = .dimmed
            }) { finished in
                // After the custom transition has finished
                if let arrangedSubviews = (self.presentedView as! FAAlertControllerView).actionsView?.stackView.arrangedSubviews {
                    for view in arrangedSubviews {
                        if view is FAAlertActionView {
                            _ = (view as! FAAlertActionView).createHighlightView()
                        }
                        
                    }
                }
            }
        } else {
            dimmingView.alpha = 1.0
        }
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        if !completed {
            dimmingView.removeFromSuperview()
            layoutView.removeFromSuperview()
            keyboardLayoutAlignmentView.removeFromSuperview()
        }
    }
    
    override func dismissalTransitionWillBegin() {
        // Fade the dimming view back out.
        if let coordinator = presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { (context) in
                self.dimmingView.alpha = 0.0
                self.presentingViewController.view.tintAdjustmentMode = .automatic
                }, completion: nil)
        } else {
            dimmingView.alpha = 0.0
        }
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            dimmingView.removeFromSuperview()
        }
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        // Get a pointer to the containerView's constraints
        let _constraints = containerView!.constraints
        // Check that the preferredStyle is `.alert`
        if FAAlertControllerAppearanceManager.sharedInstance.preferredStyle == .alert {
            // Loop through the constraints and adjust as necessary
            for constraint in _constraints {
                if constraint.firstItem as? NSObject == presentedView {
                    if newCollection.verticalSizeClass == .regular {
                        if constraint.firstAttribute == .top {
                            constraint.constant = 10
                        }
                        if constraint.firstAttribute == .bottom {
                            constraint.constant = -10
                        }
                    } else if newCollection.verticalSizeClass == .compact {
                        if constraint.firstAttribute == .top || constraint.firstAttribute == .bottom {
                            constraint.constant = 0
                        }
                    }
                }
            }
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        print("Transitioning to size: \(size) with coordinator: \(coordinator)")
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { (context) in
            self.presentedView?.layoutIfNeeded()
            if let toVC = self.presentedViewController as? FAAlertController {
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
                    }
                }
            }
        }, completion: nil)
    }

    func adjustForKeyboard(notification: NSNotification) {
        if let userInfo = notification.userInfo, let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? Double, let keyboardSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue, let animationCurveInt = (userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber)?.uintValue {
            
            if notification.name == .UIKeyboardWillHide {
                keyboardLayoutAlignmentViewHeightConstraint?.constant = 0
            }
            if notification.name == .UIKeyboardWillShow {
                keyboardLayoutAlignmentViewHeightConstraint?.constant = keyboardSize.height
            }
            UIView.animate(withDuration: duration, delay: 0.0, options: UIViewAnimationOptions(rawValue: animationCurveInt<<16),
                           animations: {
                            self.containerView?.layoutIfNeeded()
                }, completion: nil)
        }
    }
    
    func fixTextField(notification: NSNotification) {
        if notification.object is UITextField {
            print("Its a textfield")
            (notification.object as! UITextField).layoutIfNeeded()
        }
    }

}
