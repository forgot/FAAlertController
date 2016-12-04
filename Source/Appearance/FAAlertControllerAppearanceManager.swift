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
    
    var globalDelegate: FAAlertControllerAppearanceDelegate?
    
    var pickerDelegate: FAAlertControllerPickerDelegate?
    
    var _delegate = FAAlertControllerAppearanceManagerInternalDelegate()
    
    var appearanceStyle: FAAlertControllerAppearanceStyle = .default
    
    var preferredStyle: FAAlertControllerStyle = .alert
    
    var backdropView: FAAlertControllerBackdropView?
    
    var numberOfActions: Int = 0
    
    var maxWidth: CGFloat {
        switch preferredStyle {
        case .alert, .picker:
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
        if delegate != nil {
            return UIBlurEffect(style: delegate!.blurStyle)
        } else if globalDelegate != nil {
            return UIBlurEffect(style: globalDelegate!.blurStyle)
        } else {
            return UIBlurEffect(style: _delegate.blurStyle)
        }
    }
    
    var buttonTintColor: UIColor {
        if delegate != nil {
            return delegate!.buttonTintColor
        } else if globalDelegate != nil {
            return globalDelegate!.buttonTintColor
        } else {
            return _delegate.buttonTintColor
        }
    }
    
    var cancelButtonTintColor: UIColor {
        if delegate != nil {
            return delegate!.cancelButtonTintColor
        } else if globalDelegate != nil {
            return globalDelegate!.cancelButtonTintColor
        } else {
            return _delegate.cancelButtonTintColor
        }
    }
    
    var destructiveButtonTintColor: UIColor {
        if delegate != nil {
            return delegate!.destructiveButtonTintColor
        } else if globalDelegate != nil {
            return globalDelegate!.destructiveButtonTintColor
        } else {
            return _delegate.destructiveButtonTintColor
        }
    }
    
    var backdropColor: UIColor {
        if delegate != nil {
            return delegate!.backdropColor
        } else if globalDelegate != nil {
            return globalDelegate!.backdropColor
        } else {
            return _delegate.backdropColor
        }
    }
    
    var actionSheetCancelBackdropColor: UIColor {
        if delegate != nil {
            return delegate!.actionSheetCancelBackdropColor
        } else if globalDelegate != nil {
            return globalDelegate!.actionSheetCancelBackdropColor
        } else {
            return _delegate.actionSheetCancelBackdropColor
        }
    }
    
    var backdropBlendMode: CGBlendMode {
        if delegate != nil {
            return delegate!.backdropBlendMode
        } else if globalDelegate != nil {
            return globalDelegate!.backdropBlendMode
        } else {
            return _delegate.backdropBlendMode
        }
    }
    
    var titleTextColor: UIColor {
        if delegate != nil {
            return delegate!.titleTextColor
        } else if globalDelegate != nil {
            return globalDelegate!.titleTextColor
        } else {
            return _delegate.titleTextColor
        }
    }
    
    var messageTextColor: UIColor {
        if delegate != nil {
            return delegate!.messageTextColor
        } else if globalDelegate != nil {
            return globalDelegate!.messageTextColor
        } else {
            return _delegate.messageTextColor
        }
    }
    
    var textFieldTextColor: UIColor {
        if delegate != nil {
            return delegate!.textFieldTextColor
        } else if globalDelegate != nil {
            return globalDelegate!.textFieldTextColor
        } else {
            return _delegate.textFieldTextColor
        }
    }
    
    var textFieldPlaceholderTextColor: UIColor {
        if delegate != nil {
            return delegate!.textFieldPlaceholderTextColor
        } else if globalDelegate != nil {
            return globalDelegate!.textFieldPlaceholderTextColor
        } else {
            return _delegate.textFieldPlaceholderTextColor
        }
    }
    
    var textFieldBackgroundColor: UIColor {
        if delegate != nil {
            return delegate!.textFieldBackgroundColor
        } else if globalDelegate != nil {
            return globalDelegate!.textFieldBackgroundColor
        } else {
            return _delegate.textFieldBackgroundColor
        }
    }
    
    var textFieldBorderColor: UIColor {
        if delegate != nil {
            return delegate!.textFieldBorderColor
        } else if globalDelegate != nil {
            return globalDelegate!.textFieldBorderColor
        } else {
            return _delegate.textFieldBorderColor
        }
    }
    
    var separatorPrimaryColor: UIColor {
        if delegate != nil {
            return delegate!.separatorPrimaryColor
        } else if globalDelegate != nil {
            return globalDelegate!.separatorPrimaryColor
        } else {
            return _delegate.separatorPrimaryColor
        }
    }
    
    var separatorSecondaryColor: UIColor {
        if delegate != nil {
            return delegate!.separatorSecondaryColor
        } else if globalDelegate != nil {
            return globalDelegate!.separatorSecondaryColor
        } else {
            return _delegate.separatorSecondaryColor
        }
    }
    
    private init() {}
    
}

struct FAAlertControllerAppearanceManagerInternalDelegate: FAAlertControllerAppearanceDelegate {}
