//
//  FAAlertControllerTextFieldsView.swift
//  FAPlacemarkPicker
//
//  Created by Jesse Cox on 9/13/16.
//  Copyright © 2016 Apprhythmia LLC. All rights reserved.
//

import UIKit

class FAAlertControllerTextFieldsView: UIView {
    
    var textFields = [FAAlertTextFieldView]()
    
    init(withTextFields textFields: [UITextField]) {
        for _textField in textFields {
            let _field = FAAlertTextFieldView(withTextField: _textField)
            self.textFields.append(_field)
        }
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("initWithCoder not implemented")
    }
    
    func commonInit() {
        translatesAutoresizingMaskIntoConstraints = false
        let stack = UIStackView(arrangedSubviews: textFields)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        addSubview(stack)
        stack.topAnchor.constraint(equalTo: topAnchor, constant: 17.5).isActive = true
        stack.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stack.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        bottomAnchor.constraint(equalTo: stack.bottomAnchor, constant: 12).isActive = true
    }
    
}

class FAAlertTextFieldView: UIView {
    
    let textField: UITextField
    var layoutView: UIView!
    
    init(withTextField textField: UITextField) {
        self.textField = textField
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        textField.autocapitalizationType = .none
        translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = FAAlertControllerAppearanceManager.sharedInstance.textFieldTextColor
        
        heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        let blurEffect = FAAlertControllerAppearanceManager.sharedInstance.blurEffect
        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
        let effectView = UIVisualEffectView(effect: vibrancyEffect)
        
        effectView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(effectView)
        effectView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        effectView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        effectView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        effectView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        
        let borderView = UIView(frame: .zero)
        borderView.translatesAutoresizingMaskIntoConstraints = false
        borderView.backgroundColor = FAAlertControllerAppearanceManager.sharedInstance.textFieldBorderColor
        effectView.contentView.addSubview(borderView)
        borderView.centerXAnchor.constraint(equalTo: effectView.centerXAnchor).isActive = true
        borderView.centerYAnchor.constraint(equalTo: effectView.centerYAnchor).isActive = true
        borderView.widthAnchor.constraint(equalTo: effectView.widthAnchor).isActive = true
        borderView.heightAnchor.constraint(equalTo: effectView.heightAnchor).isActive = true
        
        
        layoutView = UIView(frame: .zero)
        layoutView.translatesAutoresizingMaskIntoConstraints = false
        layoutView.backgroundColor = FAAlertControllerAppearanceManager.sharedInstance.textFieldBackgroundColor
        addSubview(layoutView)
        layoutView.heightAnchor.constraint(equalTo: heightAnchor, constant: -1).isActive = true
        layoutView.widthAnchor.constraint(equalTo: widthAnchor, constant: -1).isActive = true
        layoutView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        layoutView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        layoutView.addSubview(textField)
        
        textField.heightAnchor.constraint(equalTo: layoutView.heightAnchor, constant: -8).isActive = true
        textField.widthAnchor.constraint(equalTo: layoutView.widthAnchor, constant: -8).isActive = true
        textField.centerXAnchor.constraint(equalTo: layoutView.centerXAnchor).isActive = true
        textField.centerYAnchor.constraint(equalTo: layoutView.centerYAnchor).isActive = true
        
        if let placeholder = textField.placeholder {
            let color = FAAlertControllerAppearanceManager.sharedInstance.textFieldPlaceholderTextColor
            textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSForegroundColorAttributeName: color])
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textField.frame = CGRect(x: 4, y: 4, width: layoutView.frame.width - 8, height: layoutView.frame.height - 8)
    }
    
}
