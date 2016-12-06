//
//  DarkStyleViewController.swift
//  FAAlertController
//
//  Created by Jesse Cox on 10/31/16.
//  Copyright © 2016 Apprhythmia LLC. All rights reserved.
//

import UIKit
import FAAlertController

class DarkStyleViewController: BaseViewController {
    
    override var _title: String {
        return "A Dark Alert"
    }
    override var _message: String {
        return "Not to worry, this isn't as foreboding as it sounds....."
    }
    
    override var appearanceStyle: FAAlertControllerAppearanceStyle {
        return .dark
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barStyle = .blackTranslucent
        navigationController?.toolbar.barStyle = .blackTranslucent
        
        for button in alertButtons {
            button.tintColor = .orange
        }
        for button in actionSheetButtons {
            button.tintColor = .orange
        }

        for button in pickerButtons {
            button.tintColor = .orange
        }

        
        action1Title = "Don't"
        action2Title = "Look"
        action3Title = "Behind"
        action4Title = "You"
        
        _preferredActionIndex = 2
        
        uiAlertAction1 = UIAlertAction(title: action1Title, style: .default, handler: { (action) in
            print("I said don't....")
        })
        uiAlertAction2 = UIAlertAction(title: action2Title, style: .default, handler: { (action) in
            print("Why are you looking???")
        })
        uiAlertAction3 = UIAlertAction(title: action3Title, style: .destructive, handler: { (action) in
            print("OH MY GOD THE HORROR!")
        })
        uiAlertAction4 = UIAlertAction(title: action4Title, style: .default, handler: { (action) in
            print("Wait..it was just a kitten..")
        })

        
        faAlertAction1 = FAAlertAction(title: action1Title, style: .default, handler: { (action) in
            print("I said don't....")
        })
        faAlertAction2 = FAAlertAction(title: action2Title, style: .default, handler: { (action) in
            print("Why are you looking???")
        })
        faAlertAction3 = FAAlertAction(title: action3Title, style: .destructive, handler: { (action) in
            print("OH MY GOD THE HORROR!")
        })
        faAlertAction4 = FAAlertAction(title: action4Title, style: .default, handler: { (action) in
            print("Wait..it was just a kitten..")
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
        let alert = FAAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert, appearance: .dark)
        alert.addAction(faAlertAction1)
        alert.addAction(faAlertAction2)
        alert.addAction(faAlertAction3)
        alert.addAction(faAlertAction4)
        alert.preferredAction = alert.actions[_preferredActionIndex]
        present(alert, animated: true, completion: nil)
    }
    
    override func showFAActionSheet() {
        let alert = FAAlertController(title: alertTitle, message: alertMessage, preferredStyle: .actionSheet, appearance: .dark)
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
        let title = "A Dark Picker"
        let alert = FAAlertController(title: title, message: nil, preferredStyle: .picker, appearance: appearanceStyle, items: items)
        alert.delegate = self
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
}
