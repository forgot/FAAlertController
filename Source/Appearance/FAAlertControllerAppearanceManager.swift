//
//  FAAlertControllerAppearanceManager.swift
//  FAPlacemarkPicker
//
//  Created by Jesse Cox on 9/17/16.
//  Copyright © 2016 Apprhythmia LLC. All rights reserved.
//

import UIKit

protocol Singleton: class {
    static var sharedInstance: Self { get }
}

final class FAAlertControllerAppearanceManager: Singleton {
    
    static let sharedInstance = FAAlertControllerAppearanceManager()
    
    var delegate: FAAlertControllerAppearanceDelegate?
    
    var _delegate = FAAlertControllerAppearanceManagerInternalDelegate()
    
    var appearanceStyle: FAAlertControllerAppearanceStyle = .default
    
    var preferredStyle: FAAlertControllerStyle = .alert
    
    var backdropView: FAAlertControllerBackdropView?
    
    var numberOfActions: Int = 0
    
    var maxWidth: CGFloat {
        switch preferredStyle {
        case .alert:
            return 270
        case .actionSheet:
            let bounds = UIScreen.main.bounds
            if bounds.width < bounds.height {
                return bounds.width - 20
            } else {
                return bounds.height - 20
            }
        }
    }
    
    
    // MARK: Custom Appearance
    
    var blurEffect: UIBlurEffect {
        return delegate != nil ? UIBlurEffect(style: delegate!.blurStyle) : UIBlurEffect(style: _delegate.blurStyle)
    }
    
    var buttonTintColor: UIColor {
        return delegate != nil ? delegate!.buttonTintColor : _delegate.buttonTintColor
    }
    
    var destructiveButtonTintColor: UIColor {
        return delegate != nil ? delegate!.destructiveButtonTintColor : _delegate.destructiveButtonTintColor
    }
    
    var blendViewColor: UIColor {
        return delegate != nil ? delegate!.blendViewColor : _delegate.blendViewColor
    }
    
    var titleTextColor: UIColor {
        return delegate != nil ? delegate!.titleTextColor : _delegate.titleTextColor
    }
    
    var messageTextColor: UIColor {
        return delegate != nil ? delegate!.messageTextColor : _delegate.messageTextColor
    }
    
    var textFieldTextColor: UIColor {
        return delegate != nil ? delegate!.textFieldTextColor : _delegate.textFieldTextColor
    }
    
    var textFieldPlaceholderTextColor: UIColor {
        return delegate != nil ? delegate!.textFieldPlaceholderTextColor : _delegate.textFieldPlaceholderTextColor
    }
    
    var textFieldBackgroundColor: UIColor {
        return delegate != nil ? delegate!.textFieldBackgroundColor : _delegate.textFieldBackgroundColor
    }
    
    var textFieldBorderColor: UIColor {
        return delegate != nil ? delegate!.textFieldBorderColor : _delegate.textFieldBorderColor
    }
    
    var separatorPrimaryColor: UIColor {
        return delegate != nil ? delegate!.separatorPrimaryColor : _delegate.separatorPrimaryColor
    }
    
    var separatorSecondaryColor: UIColor {
        return delegate != nil ? delegate!.separatorSecondaryColor : _delegate.separatorSecondaryColor
    }
    
    private init() {}
    
}

struct FAAlertControllerAppearanceManagerInternalDelegate: FAAlertControllerAppearanceDelegate {}
