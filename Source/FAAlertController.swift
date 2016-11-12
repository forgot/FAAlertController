//
//  FAAlertController.swift
//  FAPlacemarkPicker
//
//  Created by Jesse Cox on 8/20/16.
//  Copyright © 2016 Apprhythmia LLC. All rights reserved.
//

import UIKit


/// Constants indicating the type of alert to display.
public enum FAAlertControllerStyle {
    /// An alert displayed modally for the app.
    case alert
    /// An action sheet displayed in the context of the view controller that presented it.
    ///
    /// Use an action sheet to present the user with a set of alternatives for how to proceed with a given task. You can also use this style to prompt the user to confirm a potentially dangerous action.
    case actionSheet
}


/// Constants indicating the visual appearance of the alert to display
public enum FAAlertControllerAppearanceStyle {
    /// A style mimicing `UIAlertController`.
    case `default`
    /// A style for use with dark user interfaces.
    case dark
}


/// A FAAlertController object displays an alert message to the user. This class replaces the UIController class for displaying alerts. After configuring the alert controller with the actions and style you want, present it using the present(_:animated:completion:) method.
public class FAAlertController: UIViewController, FAAlertActionDelegate {
    
    // MARK: Public Properties
    
    
    /// The title of the alert.
    ///
    ///The title string is displayed prominently in the alert or action sheet. You should use this string to get the user’s attention and communicate the reason for displaying the alert.
    override public var title: String? {
        get {
            return super.title
        }
        set {
            super.title = newValue
        }
    }
    
    /// Descriptive text that provides more details about the reason for the alert.
    ///
    ///The message string is displayed below the title string and is less prominent. Use this string to provide additional context about the reason for the alert or about the actions that the user might take.
    public var message: String?
    
    
    /// The style of the alert controller.
    ///
    /// The value of this property is set to the value you specified in the `init(title:message:preferredStyle:appearance:)` method. This value determines how the alert is displayed onscreen.
    public var preferredStyle: FAAlertControllerStyle {
        get {
            return FAAlertControllerAppearanceManager.sharedInstance.preferredStyle
        }
        set {
            FAAlertControllerAppearanceManager.sharedInstance.preferredStyle = newValue
        }
    }
    
    /// The actions that the user can take in response to the alert or action sheet.
    ///
    /// The actions are in the order in which you added them to the alert controller. This order also corresponds to the order in which they are displayed in the alert or action sheet. The second action in the array is displayed below the first, the third is displayed below the second, and so on.
    public var actions = [FAAlertAction]()
    
    
    /// The preferred action for the user to take from an alert.
    ///
    /// The preferred action is relevant for the alert style only; it is not used by action sheets. When you specify a preferred action, the alert controller highlights the text of that action to give it emphasis. (If the alert also contains a cancel button, the preferred action receives the highlighting instead of the cancel button.) If the iOS device is connected to a physical keyboard, pressing the Return key triggers the preferred action.
    ///
    /// The action object you assign to this property must have already been added to the alert controller’s list of actions. Assigning an object to this property before adding it with the addAction(_:) method is a programmer error.
    ///
    /// The default value of this property is nil.
    public var preferredAction: FAAlertAction? {
        willSet {
            if newValue != nil && !actions.contains(newValue!) {
                assertionFailure("The -preferredAction of an alert controller must be contained in the -actions array or be nil.")
            }
        }
        didSet {
            preferredAction?.isPreferredAction = true
        }
    }
    
    /// The array of text fields displayed by the alert.
    ///
    /// Use this property to access the text fields displayed by the alert. The text fields are in the order in which you added them to the alert controller. This order also corresponds to the order in which they are displayed in the alert.
    public var textFields: [UITextField]?
    
    /// The appearance of the alert controller
    ///
    /// The value of this property is set to the value you specified in the `init(title:message:preferredStyle:appearance:)` method. This value determines how the appearance of the user interface when the alert is displayed on screen.
    public var appearanceStyle: FAAlertControllerAppearanceStyle {
        get {
            return FAAlertControllerAppearanceManager.sharedInstance.appearanceStyle
        }
        set {
            FAAlertControllerAppearanceManager.sharedInstance.appearanceStyle = newValue
        }
    }
    
    /// An optional delegate used to customize the appearance of the user interface.
    ///
    /// Set this property to an type conforming to `FAAlertControllerAppearanceDelegate` to customize the appearance of the alert.
    public var appearanceDelegate: FAAlertControllerAppearanceDelegate? {
        didSet {
            FAAlertControllerAppearanceManager.sharedInstance.delegate = appearanceDelegate
        }
    }
    
    public static var globalAppearanceDelegate: FAAlertControllerAppearanceDelegate? {
        didSet {
            FAAlertControllerAppearanceManager.sharedInstance.globalDelegate = globalAppearanceDelegate
        }
    }
    // MARK: Internal Properties
    var alertView: FAAlertControllerView?


    // MARK: Initialization
    
    
    /// Creates and returns a view controller for displaying an alert to the user.
    ///
    /// - parameter title:          The title of the alert. Use this string to get the user’s attention and communicate the reason for the alert.
    /// - parameter message:        Descriptive text that provides additional details about the reason for the alert.
    /// - parameter preferredStyle: The style to use when presenting the alert controller. Use this parameter to configure the alert controller as an action sheet or as a modal alert.
    /// - parameter appearance:     The appearance of the alert controller. Use this parameter to cinfigure the alert controller with default (light) or dark appearance. The default value of this property is `FAAlertControllerAppearanceStyle.default`.
    ///
    /// - returns: An initialized alert controller object.
    public init(title: String?, message: String?, preferredStyle: FAAlertControllerStyle, appearance: FAAlertControllerAppearanceStyle = .default) {
        super.init(nibName: nil, bundle: nil)
        self.preferredStyle = preferredStyle
        self.title = title
        self.message = message
        FAAlertControllerAppearanceManager.sharedInstance.appearanceStyle = appearance
        transitioningDelegate = self
        modalPresentationStyle = UIModalPresentationStyle.custom
        modalTransitionStyle = UIModalTransitionStyle.crossDissolve
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: View Lifecycle
    
    override public func loadView() {
        alertView = FAAlertControllerView(title: title, message: message, textFields: textFields, actions: actions, preferredAction: preferredAction)
        view = alertView!
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        let (isSane, reason) = sanityCheck()
        if !isSane {
            guard reason != nil else {
                assertionFailure("FAAlertController reached an unknown and inconsistent state")
                return
            }
            assertionFailure(reason!)
        }
        super.viewWillAppear(animated)
        view.layoutIfNeeded()
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.layoutIfNeeded()
    }
    
    override public func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
    }
    
    @objc func dismiss(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true) {}
    }
    
    
    // MARK: Actions
    
    /// Attaches an action object to the alert or action sheet.
    ///
    /// - parameter action: The action object to display as part of the alert. Actions are displayed as buttons in the alert. The action object provides the button text and the action to be performed when that button is tapped.
    ///
    /// If your alert has multiple actions, the order in which you add those actions determines their order in the resulting alert or action sheet.
    public func addAction(_ action: FAAlertAction) {
        if action.style == .cancel {
            for _action in actions {
                if _action.style == .cancel {
                    let userInfo = ["CurrentCancelAction": action]
                    let exception = NSException(name: NSExceptionName.internalInconsistencyException, reason: "FAAlertController can only have one action with a style of UIAlertActionStyleCancel", userInfo: userInfo)
                    exception.raise()
                    return
                }
            }
        }
        actions.append(action)
        action.delegate = self
    }
    
    func didPerformAction(_ action: FAAlertAction) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: Textfields
    
    /// Adds a text field to an alert.
    ///
    /// - parameter configurationHandler: A block for configuring the text field prior to displaying the alert. This block has no return value and takes a single parameter corresponding to the text field object. Use that parameter to change the text field properties.
    ///
    /// Calling this method adds an editable text field to the alert. You can call this method more than once to add additional text fields. The text fields are stacked in the resulting alert.
    ///
    /// You can add a text field only if the preferredStyle property is set to alert.
    public func addTextField(configurationHandler: ((UITextField) -> Void)? = nil) {
        guard preferredStyle == .alert else {
            assertionFailure("Text fields can only be added to an alert controller of style FAAlertControllerStyleAlert")
            return
        }
        let textfield = UITextField(frame: .zero)
        textfield.delegate = self
        textfield.autocorrectionType = .no
        textfield.keyboardAppearance = .default
        textfield.font = UIFont.systemFont(ofSize: 13)
        if textFields == nil {
            textFields = [UITextField]()
        }
        textFields!.append(textfield)
        configurationHandler!(textfield)
    }
    
    
    // MARK: Internal
    
    func sanityCheck() -> (Bool, String?) {
        if (title == nil || title?.isEmpty == true) && (message == nil || message?.isEmpty == true) && actions.isEmpty {
            return (false, "FAAlertController must have a title, a message or an action to display")
        }
        return (true, nil)
    }
    
}


// MARK: UITextFieldDelegate

extension FAAlertController: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textFields != nil {
            if textField == textFields!.last {
                textField.resignFirstResponder()
            } else {
                let index = textFields!.index(of: textField)
                let next = textFields![index! + 1]
                next.becomeFirstResponder()
            }
        }
        return true
    }
    
}


// MARK: UIViewControllerTransitioningDelegate

extension FAAlertController: UIViewControllerTransitioningDelegate {
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let transition = FAAlertTransition()
        transition.mode = .present
        return transition
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let transition = FAAlertTransition()
        transition.mode = .dismiss
        return transition
    }

    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let controller = FAAlertControllerPresentationController(presentedViewController: presented, presenting: presenting)
        return controller
    }

}
