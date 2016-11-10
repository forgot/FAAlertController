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
        return "A Hidious Example"
    }
    override var _message: String {
        return "Make it as daring as your old GeoCities page. If you want.\n\nSeriously though, please don't make it look like this...."
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        faControllerAppearanceDelegate = ExampleAppearanceDelegate()
    }
    
}

struct ExampleAppearanceDelegate: FAAlertControllerAppearanceDelegate {
    
    var buttonTintColor: UIColor {
        return .orange
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
    var blendViewColor: UIColor {
        return .purple
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

    
}
