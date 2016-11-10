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
    
    override var appearanceStyle: FAAlertControllerAppearanceStyle {
        return .dark
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barStyle = .blackTranslucent
        navigationController?.toolbar.barStyle = .blackTranslucent
    }
    
}
