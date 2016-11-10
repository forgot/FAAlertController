//
//  ViewController.swift
//  FAAlertController
//
//  Created by Jesse Cox on 9/24/16.
//  Copyright © 2016 Apprhythmia LLC. All rights reserved.
//

import UIKit
import FAAlertController

class BaseViewController: UIViewController {
    
    
    var _title: String {
        return "Hello! This is where the title goes! Amazing, right?"
    }
    var _message: String {
        return "This is a message. You can put lots of words here, and then show them to your users. Its really exciting."
    }
    var _numberOfActions = 4
    var _numberOfTextFields = 2
    
    var alertTitle: String?
    var alertMessage: String?
    
    var appearanceStyle: FAAlertControllerAppearanceStyle {
        return .default
    }
    
    var faControllerAppearanceDelegate: FAAlertControllerAppearanceDelegate?
    
    let action1Title = "Awesome"
    let action2Title = "Radical"
    let action3Title = "Cancel"
    let action4Title = "Destroy"
    let action5Title = "Foo"
    let action6Title = "Bar"
    
    var uiAlertAction1: UIAlertAction!
    var uiAlertAction2: UIAlertAction!
    var uiAlertAction3: UIAlertAction!
    var uiAlertAction4: UIAlertAction!
    var uiAlertAction5: UIAlertAction!
    var uiAlertAction6: UIAlertAction!
    
    var faAlertAction1: FAAlertAction!
    var faAlertAction2: FAAlertAction!
    var faAlertAction3: FAAlertAction!
    var faAlertAction4: FAAlertAction!
    var faAlertAction5: FAAlertAction!
    var faAlertAction6: FAAlertAction!
    
    @IBOutlet weak var uiControllerVersion: UIBarButtonItem!
    @IBOutlet weak var faControllerVersion: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = false
        navigationController?.isToolbarHidden = false
        
        alertTitle = _title
        alertMessage = _message
        
        uiControllerVersion.target = self
        uiControllerVersion.action = #selector(showUIAlert)
        faControllerVersion.target = self
        faControllerVersion.action = #selector(showFAAlert)

        uiAlertAction1 = UIAlertAction(title: action1Title, style: .default, handler: { (action) in
            print("Doing something \(self.action1Title.lowercased())....")
        })
        uiAlertAction2 = UIAlertAction(title: action2Title, style: .default, handler: { (action) in
            print("Doing something \(self.action2Title.lowercased())....")
        })
        uiAlertAction3 = UIAlertAction(title: action3Title, style: .cancel, handler: { action in
            print("Canceling the thing.....")
        })
        uiAlertAction4 = UIAlertAction(title: action4Title, style: .destructive, handler: { (action) in
            print("Destroying the thing....")
        })
        uiAlertAction5 = UIAlertAction(title: action5Title, style: .default, handler: { (action) in
            print("Doing \(self.action5Title.lowercased()) things....")
        })
        uiAlertAction6 = UIAlertAction(title: action6Title, style: .default, handler: { (action) in
            print("Doing \(self.action6Title.lowercased()) things....")
        })
        
        
        faAlertAction1 = FAAlertAction(title: action1Title, style: .default, handler: { (action) in
            print("Doing something \(self.action1Title.lowercased())....")
        })
        faAlertAction2 = FAAlertAction(title: action2Title, style: .default, handler: { (action) in
            print("Doing something \(self.action2Title.lowercased())....")
        })
        faAlertAction3 = FAAlertAction(title: action3Title, style: .cancel)
        faAlertAction4 = FAAlertAction(title: action4Title, style: .destructive, handler: { (action) in
            print("Doing \(self.action4Title.lowercased()) things....")
        })
        faAlertAction5 = FAAlertAction(title: action5Title, style: .default, handler: { (action) in
            print("Doing \(self.action5Title.lowercased()) things....")
        })
        faAlertAction6 = FAAlertAction(title: action6Title, style: .default, handler: { (action) in
            print("Doing \(self.action6Title.lowercased()) things....")
        })
        
    }
    
    @IBAction func togglePreferredType(sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            uiControllerVersion.title = "UIAlert"
            uiControllerVersion.action = #selector(showUIAlert)
            faControllerVersion.title = "FAAlert"
            faControllerVersion.action = #selector(showFAAlert)
        } else {
            uiControllerVersion.title = "UIActionSheet"
            uiControllerVersion.action = #selector(showUIActionSheet)
            faControllerVersion.title = "FAActionSheet"
            faControllerVersion.action = #selector(showFAActionSheet)
        }
        
    }
    
    func showUIAlert() {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        if _numberOfActions >= 1 {
            alert.addAction(uiAlertAction1)
        }
        if _numberOfActions >= 2 {
            alert.addAction(uiAlertAction2)
        }
        if _numberOfActions >= 3 {
            alert.addAction(uiAlertAction3)
        }
        if _numberOfActions >= 4 {
            alert.addAction(uiAlertAction4)
        }
        if _numberOfActions >= 5 {
            alert.addAction(uiAlertAction5)
        }
        if _numberOfActions >= 6 {
            alert.addAction(uiAlertAction6)
        }
        if _numberOfActions >= 2 {
            alert.preferredAction = uiAlertAction2
        }
        
        if _numberOfTextFields >= 1 {
            alert.addTextField { (textfield) in
                textfield.placeholder = "Text Field One"
            }
        }
        if _numberOfTextFields >= 2 {
            alert.addTextField { (textfield) in
                textfield.placeholder = "Text Field Two"
            }
        }
        if _numberOfTextFields >= 3 {
            alert.addTextField { (textfield) in
                textfield.placeholder = "Text Field Three"
            }
        }
        if _numberOfTextFields >= 4 {
            alert.addTextField { (textfield) in
                textfield.placeholder = "Text Field Four"
            }
        }
        if _numberOfTextFields >= 5 {
            alert.addTextField { (textfield) in
                textfield.placeholder = "Text Field Five"
            }
        }
        if _numberOfTextFields >= 6 {
            alert.addTextField { (textfield) in
                textfield.placeholder = "Text Field Five"
            }
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    func showUIActionSheet() {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .actionSheet)
        if _numberOfActions >= 1 {
            alert.addAction(uiAlertAction1)
        }
        if _numberOfActions >= 2 {
            alert.addAction(uiAlertAction2)
        }
        if _numberOfActions >= 3 {
            alert.addAction(uiAlertAction3)
        }
        if _numberOfActions >= 4 {
            alert.addAction(uiAlertAction4)
        }
        if _numberOfActions >= 5 {
            alert.addAction(uiAlertAction5)
        }
        if _numberOfActions >= 6 {
            alert.addAction(uiAlertAction6)
        }
        if _numberOfActions >= 2 {
            alert.preferredAction = uiAlertAction2
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    func showFAAlert() {
        let alert = FAAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert, appearance: appearanceStyle)
        
        alert.appearanceDelegate = faControllerAppearanceDelegate
        
        if _numberOfActions >= 1 {
            alert.addAction(faAlertAction1)
        }
        if _numberOfActions >= 2 {
            alert.addAction(faAlertAction2)
        }
        if _numberOfActions >= 3 {
            alert.addAction(faAlertAction3)
        }
        if _numberOfActions >= 4 {
            alert.addAction(faAlertAction4)
        }
        if _numberOfActions >= 5 {
            alert.addAction(faAlertAction5)
        }
        if _numberOfActions >= 6 {
            alert.addAction(faAlertAction6)
        }
        if _numberOfActions >= 2 {
            alert.preferredAction = faAlertAction2
        }
        
        if _numberOfTextFields >= 1 {
            alert.addTextField { (textfield) in
                textfield.placeholder = "Text Field One"
            }
        }
        if _numberOfTextFields >= 2 {
            alert.addTextField { (textfield) in
                textfield.placeholder = "Text Field Two"
            }
        }
        if _numberOfTextFields >= 3 {
            alert.addTextField { (textfield) in
                textfield.placeholder = "Text Field Three"
            }
        }
        if _numberOfTextFields >= 4 {
            alert.addTextField { (textfield) in
                textfield.placeholder = "Text Field Four"
            }
        }
        if _numberOfTextFields >= 5 {
            alert.addTextField { (textfield) in
                textfield.placeholder = "Text Field Five"
            }
        }
        if _numberOfTextFields >= 6 {
            alert.addTextField { (textfield) in
                textfield.placeholder = "Text Field Five"
            }
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    func showFAActionSheet() {
        let alert = FAAlertController(title: alertTitle, message: alertMessage, preferredStyle: .actionSheet, appearance: appearanceStyle)
        
        alert.appearanceDelegate = faControllerAppearanceDelegate
        
        if _numberOfActions >= 1 {
            alert.addAction(faAlertAction1)
        }
        if _numberOfActions >= 2 {
            alert.addAction(faAlertAction2)
        }
        if _numberOfActions >= 3 {
            alert.addAction(faAlertAction3)
        }
        if _numberOfActions >= 4 {
            alert.addAction(faAlertAction4)
        }
        if _numberOfActions >= 5 {
            alert.addAction(faAlertAction5)
        }
        if _numberOfActions >= 6 {
            alert.addAction(faAlertAction6)
        }
        if _numberOfActions >= 2 {
            alert.preferredAction = faAlertAction2
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func unwindToMainViewController(segue: UIStoryboardSegue) {}
}

