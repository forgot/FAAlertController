//
//  FAAlertControllerView.swift
//  FAPlacemarkPicker
//
//  Created by Jesse Cox on 8/20/16.
//  Copyright © 2016 Apprhythmia LLC. All rights reserved.
//

import UIKit


class FAAlertControllerView: UIView {
    
    var title: String?
    var message: String?
    var textFields: [UITextField]?
    var items: [Pickable]?
    var actions: [FAAlertAction]
    var preferredAction: FAAlertAction?
    var cancelAction: FAAlertAction?
    
    var interfaceView: FAAlertControllerInterfaceView!
    var headerView: FAAlertControllerHeaderView?
    var actionsView: FAAlertControllerActionsView?
    
    
    // MARK: View Lifecycle
    
    init(title: String?, message: String?, textFields: [UITextField]?, actions: [FAAlertAction]?, preferredAction: FAAlertAction?, items: [Pickable]? = nil) {
        
        self.title = title
        self.message = message
        self.textFields = textFields
        self.items = items
        self.actions = actions == nil ? [FAAlertAction]() : actions!
        self.preferredAction = preferredAction
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        prepareActions()
        
        switch FAAlertControllerAppearanceManager.sharedInstance.preferredStyle {
        case .alert:
            configureAlert()
        case .actionSheet:
            configureActionSheet()
        case .picker:
            configurePicker()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Internal Functions
    
    func configureAlert() {
        
        // Create the alert view
        interfaceView = FAAlertControllerInterfaceView()
        
        // Create and add the header view
        let headerView = FAAlertControllerHeaderView()
        headerView.title = title
        headerView.message = message
        headerView.textFields = textFields
        headerView.prepareForLayout()
        headerView.layoutIfNeeded()
        interfaceView.stack.addArrangedSubview(headerView)
        self.headerView = headerView
        
        
        // Create and add the actions view
        if !actions.isEmpty {
            
            // Create and add the separator view
            let separatorView = FAAlertControllerHorizontalSeparatorView()
            interfaceView.stack.addArrangedSubview(separatorView)
            
            let actionsView = FAAlertControllerActionsView()
            actionsView.actions = actions
            actionsView.preferredAction = preferredAction
            actionsView.cancelAction = cancelAction
            actionsView.prepareForLayout()
            actionsView.layoutIfNeeded()
            interfaceView.stack.addArrangedSubview(actionsView)
            self.actionsView = actionsView
            
        }
        
        interfaceView.stack.layoutIfNeeded()
        
        addSubview(interfaceView)
        
        // Setup constraints
        interfaceView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        interfaceView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        widthAnchor.constraint(equalTo: interfaceView.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: interfaceView.heightAnchor).isActive = true
        let constraint = headerView.heightAnchor.constraint(equalTo: interfaceView.heightAnchor, multiplier: 1.5)
        constraint.priority = 249
        addConstraint(constraint)
        constraint.isActive = true
    }
    
    func configureActionSheet() {
        
        // Create the layout view
        let layoutView = UIStackView(arrangedSubviews: [UIView]())
        layoutView.translatesAutoresizingMaskIntoConstraints = false
        layoutView.axis = .vertical
        layoutView.spacing = 8
        layoutView.heightAnchor.constraint(lessThanOrEqualToConstant: 528).isActive = true
        
        // Create the primary interface view
        interfaceView = FAAlertControllerInterfaceView()
        
        // Create and add the header view
        let headerView = FAAlertControllerHeaderView()
        headerView.title = title
        headerView.message = message
        headerView.prepareForLayout()
        headerView.layoutIfNeeded()
        interfaceView.stack.addArrangedSubview(headerView)
        self.headerView = headerView
        
        // Create and add the actions view
        if !actions.isEmpty {
            
            // Create and add the separator view
            let separatorView = FAAlertControllerHorizontalSeparatorView()
            interfaceView.stack.addArrangedSubview(separatorView)
            
            let actionsView = FAAlertControllerActionsView()
            actionsView.actions = actions
            actionsView.prepareForLayout()
            actionsView.layoutIfNeeded()
            interfaceView.stack.addArrangedSubview(actionsView)
            self.actionsView = actionsView
            
        }
        
        interfaceView.stack.layoutIfNeeded()
        interfaceView.layoutIfNeeded()
        
        
        // Add the primary interface view
        layoutView.addArrangedSubview(interfaceView)

        
        // If the cancel action is not nil, create and configure a secondary interface view
        if cancelAction != nil {
            
            // Create the secondary interface view
            let secondaryInterfaceView = FAAlertControllerInterfaceView(withBackdrop: false)
            
            // Create and add the actions view
            let cancelActionView = FAAlertControllerActionsView()
            cancelActionView.actions = [cancelAction!]
            cancelActionView.prepareForLayout()
            cancelActionView.layoutIfNeeded()
            secondaryInterfaceView.stack.addArrangedSubview(cancelActionView)
            
            secondaryInterfaceView.stack.layoutIfNeeded()
            secondaryInterfaceView.layoutIfNeeded()
            
            // Add the secondary interface view
            layoutView.addArrangedSubview(secondaryInterfaceView)
        }

        
        addSubview(layoutView)
        layoutView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        layoutView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        widthAnchor.constraint(equalTo: layoutView.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: layoutView.heightAnchor).isActive = true
        
        let constraint = headerView.heightAnchor.constraint(equalTo: layoutView.heightAnchor, multiplier: 1.5)
        constraint.priority = 249
        addConstraint(constraint)
        constraint.isActive = true
        
        layoutView.layoutIfNeeded()
        layoutIfNeeded()
        
    }
    
    func configurePicker() {
        
        // Create the alert view
        interfaceView = FAAlertControllerInterfaceView()
        
        // Create and add the header view
        let headerView = FAAlertControllerHeaderView()
        headerView.title = title
        headerView.message = message
        headerView.items = items
        headerView.prepareForLayout()
        headerView.layoutIfNeeded()
        interfaceView.stack.addArrangedSubview(headerView)
        self.headerView = headerView
        
        
        // Create and add the actions view
        if !actions.isEmpty {
            
            // Create and add the separator view
            let separatorView = FAAlertControllerHorizontalSeparatorView()
            interfaceView.stack.addArrangedSubview(separatorView)
            
            let actionsView = FAAlertControllerActionsView()
            actionsView.actions = actions
            actionsView.preferredAction = preferredAction
            actionsView.cancelAction = cancelAction
            actionsView.prepareForLayout()
            actionsView.layoutIfNeeded()
            interfaceView.stack.addArrangedSubview(actionsView)
            self.actionsView = actionsView
            
        } else { // Add default cancel action
            actions = [FAAlertAction(title: "Cancel", style: .cancel, handler: nil)]
        }
        
        interfaceView.stack.layoutIfNeeded()
        
        addSubview(interfaceView)
        
        // Setup constraints
        interfaceView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        interfaceView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        widthAnchor.constraint(equalTo: interfaceView.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: interfaceView.heightAnchor).isActive = true
        let constraint = headerView.heightAnchor.constraint(equalTo: interfaceView.heightAnchor, multiplier: 1.5)
        constraint.priority = 249
        addConstraint(constraint)
        constraint.isActive = true
        
    }
        
    /// Prepares the array of FAAlertAction items by identifying the preferredAction and cancelAction, if any, and sorting the array accordingly.
    func prepareActions() {
        
        for action in actions {
            if action.style == .cancel {
                guard let index = actions.index(of: action) else {
                    preconditionFailure("The index of the action is nil, which should never ever happen if it was able to be identified in the first place.")
                }
                cancelAction = actions.remove(at: index)
                if preferredAction == nil {
                    cancelAction?.isPreferredAction = true
                }
            }
        }
        
        if FAAlertControllerAppearanceManager.sharedInstance.preferredStyle == .alert || FAAlertControllerAppearanceManager.sharedInstance.preferredStyle == .picker {
            if let _cancelAction = cancelAction {
                actions.append(_cancelAction)
            }
        }
        
        FAAlertControllerAppearanceManager.sharedInstance.numberOfActions = actions.count
        
    }
}
