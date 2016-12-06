//
//  CustomStyleViewController.swift
//  FAAlertController
//
//  Created by Jesse Cox on 10/31/16.
//  Copyright © 2016 Apprhythmia LLC. All rights reserved.
//

import UIKit
import FAAlertController

class CustomStyleViewController: BaseViewController {
    
    override var _title: String {
        return "Welcome To Forgot's Alert Page"
    }
    override var _message: String {
        return "Make it as daring as your old GeoCities page. If you want.\n\nSeriously though, please don't make it look like this...."
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        faControllerAppearanceDelegate = ExampleAppearanceDelegate()
        
        action1Title = "Home"
        action2Title = "Links"
        action3Title = "About Me"
        action4Title = "<- Go Back"
        
        _preferredActionIndex = 1
        
        uiAlertAction1 = UIAlertAction(title: action1Title, style: .default, handler: { (action) in
            print("https://github.com/forgot/FAAlertController")
        })
        uiAlertAction2 = UIAlertAction(title: action2Title, style: .default, handler: { (action) in
            print("https://github.com/forgot?tab=repositories")
        })
        uiAlertAction3 = UIAlertAction(title: action3Title, style: .destructive, handler: { (action) in
            print("https://github.com/forgot")
        })
        uiAlertAction4 = UIAlertAction(title: action4Title, style: .cancel, handler: { (action) in
            print("Bye!")
        })
        
        
        faAlertAction1 = FAAlertAction(title: action1Title, style: .default, handler: { (action) in
            print("https://github.com/forgot/FAAlertController")
        })
        faAlertAction2 = FAAlertAction(title: action2Title, style: .default, handler: { (action) in
            print("https://github.com/forgot?tab=repositories")
        })
        faAlertAction3 = FAAlertAction(title: action3Title, style: .destructive, handler: { (action) in
            print("https://github.com/forgot")
        })
        faAlertAction4 = FAAlertAction(title: action4Title, style: .cancel, handler: { (action) in
            print("Bye!")
        })


    }
    
    override func showUIAlert() {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alert.addAction(uiAlertAction1)
        alert.addAction(uiAlertAction2)
        alert.addAction(uiAlertAction3)
        alert.addAction(uiAlertAction4)
        alert.preferredAction = alert.actions[_preferredActionIndex]
        present(alert, animated: true, completion: nil)
    }
    
    override func showUIActionSheet() {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .actionSheet)
        alert.addAction(uiAlertAction1)
        alert.addAction(uiAlertAction2)
        alert.addAction(uiAlertAction3)
        alert.addAction(uiAlertAction4)
        alert.preferredAction = alert.actions[_preferredActionIndex]
        present(alert, animated: true, completion: nil)
    }
    
    override func showFAAlert() {
        let alert = FAAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert, appearance: .default)
        alert.appearanceDelegate = faControllerAppearanceDelegate
        alert.addAction(faAlertAction1)
        alert.addAction(faAlertAction2)
        alert.addAction(faAlertAction3)
        alert.addAction(faAlertAction4)
        alert.preferredAction = alert.actions[_preferredActionIndex]
        present(alert, animated: true, completion: nil)
    }
    
    override func showFAActionSheet() {
        let alert = FAAlertController(title: alertTitle, message: alertMessage, preferredStyle: .actionSheet, appearance: .default)
        alert.appearanceDelegate = faControllerAppearanceDelegate
        alert.addAction(faAlertAction1)
        alert.addAction(faAlertAction2)
        alert.addAction(faAlertAction3)
        alert.addAction(faAlertAction4)
        alert.preferredAction = alert.actions[_preferredActionIndex]
        present(alert, animated: true, completion: nil)
    }

    override func showPicker() {
        // Create items
        let itemOne = PickableItem(title: "Network One", subtitle: "A pretty good network")
        let itemTwo = PickableItem(title: "Network Two", subtitle: "Almost as good as Network One")
        let itemThree = PickableItem(title: "Network Three", subtitle: "Don't pick this one")
        let items = [itemOne, itemTwo, itemThree]
        
        // Create Cancel Action
        let cancel = FAAlertAction(title: "Cancel", style: .cancel)
        
        // Setup Alert
        let title = "A Custom Picker"
        let alert = FAAlertController(title: title, message: nil, preferredStyle: .picker, appearance: appearanceStyle, items: items)
        alert.delegate = self
        alert.appearanceDelegate = faControllerAppearanceDelegate
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
}

struct ExampleAppearanceDelegate: FAAlertControllerAppearanceDelegate {
    
    var buttonTintColor: UIColor {
        return .orange
    }
    var cancelButtonTintColor: UIColor {
        return .magenta
    }
    var destructiveButtonTintColor: UIColor {
        return .green
    }
    var titleTextColor: UIColor {
        return .red
    }
    var messageTextColor: UIColor {
        return .blue
    }
    var blurStyle: UIBlurEffectStyle {
        return .light
    }
    var backdropColor: UIColor {
        return .purple
    }
    var actionSheetCancelBackdropColor: UIColor {
        return .purple
    }
    var backdropBlendMode: CGBlendMode {
        return .overlay
    }
    var textFieldTextColor: UIColor {
        return .cyan
    }
    var textFieldPlaceholderTextColor: UIColor {
        return .magenta
    }
    var textFieldBackgroundColor: UIColor {
        return .brown
    }
    var textFieldBorderColor: UIColor {
        return .yellow
    }
    
    var separatorPrimaryColor: UIColor {
        return .white
    }
    var separatorSecondaryColor: UIColor {
        return .lightGray
    }

    var tableViewBackgroundColor: UIColor {
        return .cyan
    }
    
    var tableViewSeparatorColor: UIColor {
        return .green
    }
    
    var tableViewCellBackgroundColor: UIColor {
        return .yellow
    }
    
}
