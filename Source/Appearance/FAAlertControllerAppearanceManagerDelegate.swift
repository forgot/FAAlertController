//
//  FAAlertControllerAppearanceManagerDelegate.swift
//  FAAlertController
//
//  Created by Jesse Cox on 10/31/16.
//  Copyright © 2016 Apprhythmia LLC. All rights reserved.
//

import UIKit

public protocol FAAlertControllerAppearanceDelegate {
    
    var buttonTintColor: UIColor { get }
    var cancelButtonTintColor: UIColor { get }
    var destructiveButtonTintColor: UIColor { get }
    var titleTextColor: UIColor { get }
    var messageTextColor: UIColor { get }
    
    var blurStyle: UIBlurEffectStyle { get }
    
    var backdropColor: UIColor { get }
    var backdropBlendMode: CGBlendMode { get }
    
    var actionSheetCancelBackdropColor: UIColor { get }
    
    var textFieldTextColor: UIColor { get }
    var textFieldPlaceholderTextColor: UIColor { get }
    var textFieldBackgroundColor: UIColor { get }
    var textFieldBorderColor: UIColor { get }
    
    var separatorPrimaryColor: UIColor { get }
    var separatorSecondaryColor: UIColor { get }
}

public extension FAAlertControllerAppearanceDelegate {
    
    
    var appearanceStyle: FAAlertControllerAppearanceStyle {
        return FAAlertControllerAppearanceManager.sharedInstance.appearanceStyle
    }
    
    var preferredStyle: FAAlertControllerStyle {
        return FAAlertControllerAppearanceManager.sharedInstance.preferredStyle
    }
    
    
    var buttonTintColor: UIColor {
        switch appearanceStyle {
        case .default:
            return UIColor(red:0, green:0.478, blue:1, alpha:1)
        case .dark:
            return .white
        }
    }
    
    var cancelButtonTintColor: UIColor {
        switch appearanceStyle {
        case .default:
            return UIColor(red:0, green:0.478, blue:1, alpha:1)
        case .dark:
            return .white
        }
    }
    
    var destructiveButtonTintColor: UIColor {
        return UIColor(red: 1.0, green: 0.231, blue: 0.188, alpha: 1.0)
    }
    var titleTextColor: UIColor {
        switch appearanceStyle {
        case .default:
            switch preferredStyle {
            case .alert:
                return .black
            case .actionSheet:
                return UIColor(red:0.561, green:0.561, blue:0.561, alpha:1)
            }
        case .dark:
            return .white
        }
    }
    var messageTextColor: UIColor {
        switch appearanceStyle {
        case .default:
            switch preferredStyle {
            case .alert:
                return .black
            case .actionSheet:
                return UIColor(red:0.561, green:0.561, blue:0.561, alpha:1)
            }
        case .dark:
            return .white
        }
    }
    var blurStyle: UIBlurEffectStyle {
        switch appearanceStyle {
        case .default:
            return .extraLight
        case .dark:
            return .dark
        }
    }
    var backdropColor: UIColor {
        return .white
    }
    
    var actionSheetCancelBackdropColor: UIColor {
        switch appearanceStyle {
        case .default:
            return .white
        case .dark:
            return UIColor(white: 0.1, alpha: 1.0)
        }
    }
    
    var backdropBlendMode: CGBlendMode {
        return .overlay
    }
    
    var textFieldTextColor: UIColor {
        switch appearanceStyle {
        case .default:
            return .black
        case .dark:
            return .white
        }
    }
    var textFieldPlaceholderTextColor: UIColor {
        switch appearanceStyle {
        case .default:
            return UIColor(red: 0.0, green: 0.0, blue: 25/255, alpha: 0.22)
        case .dark:
            return UIColor(white: 1.0, alpha: 0.5)
        }
    }
    var textFieldBackgroundColor: UIColor {
        switch appearanceStyle {
        case .default:
            return .white
        case .dark:
            return UIColor(white: 0.25, alpha: 1.0)
        }
    }
    var textFieldBorderColor: UIColor {
        switch appearanceStyle {
        case .default:
            return UIColor(white: 0.25, alpha: 1.0)
        case .dark:
            return .white
        }
    }
    
    var separatorPrimaryColor: UIColor {
        switch appearanceStyle {
        case .default:
            return UIColor(white: 64/255, alpha: 1.0)
        case .dark:
            return .white
        }
    }
    var separatorSecondaryColor: UIColor {
        switch appearanceStyle {
        case .default:
            return UIColor(red: 0, green: 0, blue: 80/255, alpha: 0.05)
        case .dark:
            return .white
        }
    }

    
}
